import 'package:flutter/material.dart';
import 'package:movie_app/Models/genre.dart';

class MovieGenres with ChangeNotifier {
  List<Genre> _items = [];
  List<Genre> get items => [..._items];

  void setMovieGenresFromJson(genres) {
    _items = [];
    for (var genre in genres) {
      _items.add(
        Genre(
          id: genre['id'],
          genreName: genre['name'],
        ),
      );
    }
    notifyListeners();
  }

  String findGenreNameByid(List genreIdList) {
    String finalGenreName = '';

    for(int x=0; x<genreIdList.length; x++)
    {
      finalGenreName += _items.firstWhere((genre) => genre.id == genreIdList[x]).genreName +', ';
    }
    return finalGenreName;
  }

  Color findGenreByid(int genreId) {
    Color borderColor = Colors.purple;
    String genreResult = _items.firstWhere((genre) => genre.id == genreId, orElse: null).genreName;

    if(genreResult == "Action")
    {
      borderColor = Colors.red;
    }
    else if(genreResult == "Drama")
    {
      borderColor = Colors.blue;
    }
    else if(genreResult == "Comedy")
    {
      borderColor = Colors.green;
    }
    else if(genreResult == "Animation")
    {
      borderColor = Colors.yellow;
    }

    return borderColor;
  }
}
