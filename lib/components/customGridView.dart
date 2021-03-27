import 'package:flutter/material.dart';

import 'package:movie_app/Models/movie.dart';
import 'package:movie_app/Models/tv.dart';
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

    List<Movie> allMovies = moviesList.items;
    List<Tv> allTvs = tvsList.items;

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
        itemCount: status == "Movies" ? allMovies.length : allTvs.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
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
                      imageUrl: MovieAPI.imageHost +
                          (status == "Movies"
                              ? allMovies[index].imagePath
                              : allTvs[index].imagePath),
                    ),
                    Text(
                      status == "Movies"
                          ? allMovies[index].scoreInWord
                          : allTvs[index].scoreInWord,
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
          );
        },
      ),
    );
  }
}
