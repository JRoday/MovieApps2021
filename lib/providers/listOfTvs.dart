import 'package:flutter/material.dart';
import 'package:movie_app/Models/tv.dart';

class ListOfTvs with ChangeNotifier {
  List<Tv> _items = [];
  List<Tv> get items => [..._items];

  void setTvFromJson(listOfTvs) {
    for (var tv in listOfTvs) {
      _items.add(
        Tv(
          id: tv['id'],
          title: tv['original_name'],
          releaseDate: tv['first_air_date'],
          overview: tv['overview'],
          imagePath: tv['poster_path'],
          score: tv['vote_average']
              .toDouble(), // use toDouble because some vote_averages are in INT
          genre: tv['genre_ids'],
          scoreInWord: tv['vote_average'] > 7
              ? 'A'
              : tv['vote_average'] > 5
                  ? 'B'
                  : tv['vote_average'] > 3
                      ? 'C'
                      : 'D',
        ),
      );
    }
    notifyListeners();
  }
}
