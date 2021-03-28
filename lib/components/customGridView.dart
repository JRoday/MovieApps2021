import 'package:flutter/material.dart';

import 'package:movie_app/Models/movie_and_tv.dart';
import 'package:movie_app/providers/listOfFavorite.dart';
import 'package:movie_app/providers/listOfMovies.dart';
import 'package:movie_app/providers/listOfTvs.dart';
import 'package:movie_app/providers/movieGenres.dart';
import 'package:movie_app/providers/tvGenres.dart';
import 'package:movie_app/services/config.dart';

import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomGridView extends StatefulWidget {
  CustomGridView(this.status, this.method);

  static String tag = 'Dashboard';
  final String status;
  final Function method;

  @override
  _CustomGridView createState() => _CustomGridView();
}

class _CustomGridView extends State<CustomGridView> {
  Color borderColor;
  String genreName;
  @override
  Widget build(BuildContext context) {
    final double gridHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    final double gridWidth = MediaQuery.of(context).size.width / 2;

    ListOfMovies moviesList = Provider.of<ListOfMovies>(context);
    ListOfTvs tvsList = Provider.of<ListOfTvs>(context);
    ListOfFavorite favoriteList = Provider.of<ListOfFavorite>(context);
    MovieGenres movieGenres = Provider.of<MovieGenres>(context);
    TvGenres tvGenres = Provider.of<TvGenres>(context);

    List<MovieAndTv> allMovies = moviesList.items;
    List<MovieAndTv> allTvs = tvsList.items;
    List<MovieAndTv> allFavorite = favoriteList.list;
    List<MovieAndTv> screenList;

    if (widget.status == "Movies") {
      screenList = allMovies;
    } else if (widget.status == "Tvs") {
      screenList = allTvs;
    } else {
      screenList = allFavorite;
    }

    return Padding(
      padding: EdgeInsets.only(
        right: 15.0,
        left: 15.0,
        top: 5.0,
      ),
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: gridWidth / gridHeight,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: screenList.length,
          itemBuilder: (BuildContext context, index) {
            if (widget.status == "Movies") {
              borderColor =
                  movieGenres.findGenreByid(screenList[index].genre[0]);

              genreName =
                  movieGenres.findGenreNameByid(screenList[index].genre);
            } else if (widget.status == "Tvs") {
              borderColor = tvGenres.findGenreByid(
                screenList[index].genre[0],
              );

              genreName = tvGenres.findGenreNameByid(screenList[index].genre);
            } else {
              try {
                borderColor =
                    movieGenres.findGenreByid(screenList[index].genre[0]);
              } catch (err) {
                borderColor = tvGenres.findGenreByid(
                  screenList[index].genre[0],
                );
              }

              try {
                genreName =
                    movieGenres.findGenreNameByid(screenList[index].genre);
              } catch (err) {
                genreName = tvGenres.findGenreNameByid(screenList[index].genre);
              }
            }

            return GestureDetector(
              onTap: () {
                return showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(
                          child: Text(
                              allFavorite.contains(screenList[index]) == false
                                  ? "Add Favorite"
                                  : "Remove Favorite",
                              style: TextStyle(
                                fontSize: 30.0,
                              )),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Apakah anda ingin " +
                                  (allFavorite.contains(screenList[index]) ==
                                          false
                                      ? "menambahkan"
                                      : "menghapus") +
                                  " item ini " +
                                  (allFavorite.contains(screenList[index]) ==
                                          false
                                      ? "ke"
                                      : "dari") +
                                  " halaman favorite?",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (allFavorite
                                            .contains(screenList[index]) ==
                                        false) {
                                      favoriteList
                                          .addToFavorite(screenList[index]);
                                    } else {
                                      favoriteList.removeFromFavorite(
                                          screenList[index]);
                                    }

                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Ya",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Tidak",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8.0,
                    ),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(
                      10.0,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      20.0,
                                    ),
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  imageUrl: MovieAPI.imageHost +
                                      screenList[index].imagePath,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 5.0,
                                  top: 5.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(200)),
                                    color: Colors.limeAccent,
                                  ),
                                  height:
                                      0.04 * MediaQuery.of(context).size.height,
                                  width:
                                      0.08 * MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      screenList[index].scoreInWord,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 5.0,
                                  top: 5.0,
                                ),
                                child: Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Opacity(
                                      opacity: allFavorite.contains(
                                                  screenList[index]) ==
                                              false
                                          ? 0
                                          : 1,
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 30.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 5.0,
                                  bottom: 5.0,
                                ),
                                child: Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.grey,
                                      ),
                                      height: 0.04 *
                                          MediaQuery.of(context).size.height,
                                      width: 0.1 *
                                          MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text(
                                          screenList[index].score.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.0,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                screenList[index].title,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Release date : " +
                                    screenList[index].releaseDate,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                genreName,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    screenList[index].overview,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<Null> refreshPage() async {
    await Future.delayed(new Duration(seconds: 3));

    setState(() {
      widget.method();
    });

    return null;
  }
}
