import 'package:flutter/material.dart';
import 'package:movie_app/components/customGridView.dart';
import 'package:movie_app/pages/favorite.dart';

import 'package:movie_app/providers/listOfMovies.dart';
import 'package:movie_app/providers/listOfTvs.dart';
import 'package:movie_app/providers/movieGenres.dart';
import 'package:movie_app/providers/tvGenres.dart';
import 'package:movie_app/services/config.dart';
import 'package:movie_app/services/networking.dart';

import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  static String tag = 'Dashboard';

  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final GlobalKey<RefreshIndicatorState> refreshKey =
      new GlobalKey<RefreshIndicatorState>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callAPI(); // This method specific for movie and tv lists,for refresh calling
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFDB9E),
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.star,
              color: Colors.yellow,
              size: 0.04 * MediaQuery.of(context).size.height,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Favorite(),
                ),
              );
            },
          )
        ],
      ),
      body: _currentIndex == 0
          ? CustomGridView('Movies', callAPI)
          : CustomGridView('Tvs', callAPI),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              //                    <--- top side
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          iconSize: 0.03 * MediaQuery.of(context).size.height,
          currentIndex: _currentIndex,
          backgroundColor: Colors.white,
          unselectedFontSize: 20.0,
          selectedFontSize: 30.0,
          selectedIconTheme:
              IconThemeData(size: 0.05 * MediaQuery.of(context).size.height),
          selectedItemColor: Colors.green,
          items: [
            BottomNavigationBarItem(
              label: 'Movies',
              icon: Icon(
                Icons.local_movies,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Tv Series',
              icon: Icon(Icons.tv),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  void callAPI() async {
    dynamic movies = await getMoviesData();
    dynamic tvs = await getTvsData();
    dynamic movieGenres = await getMovieGenresData();
    dynamic tvGenres = await getTvGenresData();

    Provider.of<ListOfMovies>(context, listen: false)
        .setMovieFromJson(movies['results']);
    Provider.of<ListOfTvs>(context, listen: false)
        .setTvFromJson(tvs['results']);
    Provider.of<MovieGenres>(context, listen: false)
        .setMovieGenresFromJson(movieGenres['genres']);
    Provider.of<TvGenres>(context, listen: false)
        .setTvGenresFromJson(tvGenres['genres']);
  }

  Future<dynamic> getMoviesData() async {
    Networking networkHelper =
        Networking(MovieAPI.host, MovieAPI.urlPopularMovieList, MovieAPI.key);
    var moviesData = await networkHelper.getData();
    return moviesData;
  }

  Future<dynamic> getTvsData() async {
    Networking networkHelper =
        Networking(MovieAPI.host, MovieAPI.urlPopularTvSeries, MovieAPI.key);
    var tvsData = await networkHelper.getData();
    return tvsData;
  }

  Future<dynamic> getMovieGenresData() async {
    Networking networkHelper =
        Networking(MovieAPI.host, MovieAPI.urlMovieGenres, MovieAPI.key);
    var movieGenresData = await networkHelper.getData();
    return movieGenresData;
  }

  Future<dynamic> getTvGenresData() async {
    Networking networkHelper =
        Networking(MovieAPI.host, MovieAPI.urlTvGenres, MovieAPI.key);
    var tvGenresData = await networkHelper.getData();
    return tvGenresData;
  }
}
