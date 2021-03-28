import 'package:flutter/cupertino.dart';

class MovieAndTv {

  MovieAndTv({
    this.id,
    this.title,
    this.releaseDate,
    this.overview,
    this.imagePath,
    this.score,
    this.genre,
    this.scoreInWord,
    this.borderColor,
  });

  int id;
  String title, releaseDate, overview, imagePath, scoreInWord;
  double score;
  List genre;
  Color borderColor;
}