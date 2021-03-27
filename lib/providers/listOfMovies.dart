import 'package:flutter/material.dart';
import 'package:movie_app/Models/movie_and_tv.dart';

class ListOfMovies with ChangeNotifier {
  List<MovieAndTv> _items = [];
  List<MovieAndTv> get items => [..._items];

  void setMovieFromJson(listOfMovies) {
    for (var movie in listOfMovies) {
      _items.add(
        MovieAndTv(
          id: movie['id'],
          title: movie['original_title'],
          releaseDate: movie['release_date'],
          overview: movie['overview'],
          imagePath: movie['poster_path'],
          score: movie['vote_average']
              .toDouble(), // use toDouble because some vote_averages are in INT
          genre: movie['genre_ids'],
          scoreInWord: movie['vote_average'] > 7
              ? 'A'
              : movie['vote_average'] > 5
                  ? 'B'
                  : movie['vote_average'] > 3
                      ? 'C'
                      : 'D',
        ),
      );
    }
    notifyListeners();
  }

  set statusFavorite(int searchId) {
    
    this.notifyListeners();
  }
}
