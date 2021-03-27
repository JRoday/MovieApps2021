import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  static String tag = 'Dashboard';

  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            },
          )
        ],
      ),
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
}
