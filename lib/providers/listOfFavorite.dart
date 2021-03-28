import 'package:flutter/cupertino.dart';
import 'package:movie_app/Models/movie_and_tv.dart';

class ListOfFavorite with ChangeNotifier{
  Color borderColor;
  List<MovieAndTv> favoriteList = [];

  void addToFavorite(MovieAndTv favoriteMovieOrTv)
  {
    favoriteList.add(favoriteMovieOrTv);
    notifyListeners();
  }

  void removeFromFavorite(MovieAndTv favoriteMovieOrTv)
  {
    favoriteList.remove(favoriteMovieOrTv);
    notifyListeners();
  }

  int get listSize{
    return this.favoriteList.length;
  }

  List<MovieAndTv> get list {
    return this.favoriteList;
  }
}