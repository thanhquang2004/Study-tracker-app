import 'package:flutter/material.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

// Regular
TextStyle getRegularStyle(
    {double fontSize = FontSize.s14,Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

// Light
TextStyle getLightStyle(
    {double fontSize = FontSize.s14,Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

// Medium
TextStyle getMediumStyle(
    {double fontSize = FontSize.s14,Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// SemiBold
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s14,Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

// Bold
TextStyle getBoldStyle({double fontSize = FontSize.s14,Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}
