import 'package:flutter/material.dart';

/// Convert hex color string to Flutter Color
/// Example: "#FF0000" -> Color(0xFFFF0000)
Color hexToColor(String hexString) {
  try {
    // Remove the # if present
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff'); // Add opacity if not present
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  } catch (e) {
    // Return a default color if conversion fails
    return Colors.black;
  }
}

/// Convert Flutter Color to hex string
/// Example: Color(0xFFFF0000) -> "#FF0000"
String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2)}';
}
