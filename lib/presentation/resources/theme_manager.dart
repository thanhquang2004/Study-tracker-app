import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColor: XColors.primary,
  );
}
