import 'package:flutter/material.dart';
import 'package:movie_app/Models/movie_and_tv.dart';

class ListOfTvs with ChangeNotifier {
  List<MovieAndTv> _items = [];
  List<MovieAndTv> get items => [..._items];

  void setTvFromJson(listOfTvs) {
    _items = [];
    for (var tv in listOfTvs) {
      _items.add(
        MovieAndTv(
          id: tv['id'],
          title: tv['original_name'],
          releaseDate: tv['first_air_date'],
          overview: tv['overview'],
          imagePath: tv['poster_path'],
          score: tv['vote_average']
              .toDouble(), // use toDouble because some vote_averages are in INT
          genre: tv['genre_ids'],
          scoreInWord: tv['vote_average'] >= 8
              ? 'A'
              : tv['vote_average'] >= 6
                  ? 'B'
                  : tv['vote_average'] >= 4
                      ? 'C'
                      : 'D',
        ),
      );
    }
    notifyListeners();
  }
}
