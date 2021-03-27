import 'package:flutter/material.dart';
import 'package:movie_app/pages/dashboard.dart';
import 'package:movie_app/pages/splashscreen.dart';
import 'package:movie_app/providers/listOfFavorite.dart';
import 'package:movie_app/providers/listOfMovies.dart';
import 'package:movie_app/providers/listOfTvs.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: SplashScreen());
        } else {
          // Loading is done, return the app:
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: ListOfMovies(),
              ),
              ChangeNotifierProvider.value(
                value: ListOfTvs(),
              ),
              ChangeNotifierProvider.value(
                value: ListOfFavorite(),
              ),
            ],
            child: MaterialApp(
              home: Dashboard(),
            ),
          );
        }
      },
    );
  }
}
