import 'package:flutter/material.dart';

class Constants {
  static late double _screenWidth;
  static late double _screenHeight;

  static void initialize(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
  }

  static double get deviceWidth => _screenWidth;
  static double get deviceHeight => _screenHeight;
}