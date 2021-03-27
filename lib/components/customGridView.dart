import 'package:flutter/material.dart';

import 'package:movie_app/Models/movie_and_tv.dart';
import 'package:movie_app/providers/listOfFavorite.dart';
import 'package:movie_app/providers/listOfMovies.dart';
import 'package:movie_app/providers/listOfTvs.dart';
import 'package:movie_app/services/config.dart';

import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomGridView extends StatelessWidget {
  CustomGridView(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    final double gridHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    final double gridWidth = MediaQuery.of(context).size.width / 1.5;

    ListOfMovies moviesList = Provider.of<ListOfMovies>(context);
    ListOfTvs tvsList = Provider.of<ListOfTvs>(context);
    ListOfFavorite favoriteList = Provider.of<ListOfFavorite>(context);

    List<MovieAndTv> allMovies = moviesList.items;
    List<MovieAndTv> allTvs = tvsList.items;
    List<MovieAndTv> allFavorite = favoriteList.list;
    List<MovieAndTv> screenList;

    if (status == "Movies") {
      screenList = allMovies;
    } else if (status == "Tvs") {
      screenList = allTvs;
    } else {
      screenList = allFavorite;
    }

    return Padding(
      padding: EdgeInsets.all(
        15.0,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: gridWidth / gridHeight,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 20,
        ),
        itemCount: screenList.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              return showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Center(
                        child: Text(
                          allFavorite.contains(screenList[index])  == false
                              ? "Add Favorite"
                              : "Remove Favorite",
                        ),
                      ),
                      content: Expanded(
                        child: Text(
                          "Apakah anda ingin " +
                              (allFavorite.contains(screenList[index])  == false
                                  ? "menambahkan"
                                  : "menghapus") +
                              " item ini dari favorite?",
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if(allFavorite.contains(screenList[index]) == false)
                            {
                              favoriteList.addToFavorite(screenList[index]);
                            }
                            else
                            {
                              favoriteList.removeFromFavorite(screenList[index]);
                            }

                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Ya",
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Tidak",
                          ),
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              color: Colors.green,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(
                    10.0,
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        // fit: BoxFit.fitWidth,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageUrl:
                            MovieAPI.imageHost + screenList[index].imagePath,
                      ),
                      Text(
                        screenList[index].scoreInWord,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
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
    );
  }
}
