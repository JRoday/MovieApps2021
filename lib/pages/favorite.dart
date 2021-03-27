import 'package:flutter/material.dart';
import 'package:movie_app/components/customGridView.dart';
import 'package:movie_app/providers/listOfFavorite.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  @override
  _Favorite createState() => _Favorite();
}

class _Favorite extends State<Favorite> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListOfFavorite favoriteList = Provider.of<ListOfFavorite>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
      body: favoriteList.listSize > 0
          ? CustomGridView(
              'Favorite',
            )
          : Text(
              '',
            ),
    );
  }
}
