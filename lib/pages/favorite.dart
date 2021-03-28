import 'package:flutter/material.dart';
import 'package:movie_app/components/customGridView.dart';
import 'package:movie_app/providers/listOfFavorite.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  @override
  _Favorite createState() => _Favorite();
}

class _Favorite extends State<Favorite> {
  int counter = 1;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListOfFavorite favoriteList = Provider.of<ListOfFavorite>(context);

    return Scaffold(
      backgroundColor: Color(0xffFFDB9E),
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
      body: Scaffold(
        backgroundColor: Color(0xffFFDB9E),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SortBy',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              DropdownButton(
              value: counter,
              items: [
                DropdownMenuItem(
                  child: Text("Name Title"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Genre"),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text("Date"),
                  value: 3
                ),
                DropdownMenuItem(
                    child: Text("Score"),
                    value: 4
                )
              ],
              onChanged: (value) {
                setState(() {
                  counter = value;
                });
              }),
            ],
          ),
        ),
        body: favoriteList.listSize > 0
            ? CustomGridView('Favorite', () {})
            : Text(
                '',
              ),
      ),
    );
  }
}
