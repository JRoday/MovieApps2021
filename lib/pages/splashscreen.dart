import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          'MOVIE APP',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
