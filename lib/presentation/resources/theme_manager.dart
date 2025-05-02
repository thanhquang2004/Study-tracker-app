import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_tracker_mobile/presentation/resources/color_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/styles_manager.dart';
import 'package:study_tracker_mobile/presentation/resources/value_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColor: XColors.primary,
    appBarTheme: AppBarTheme(
      color: XColors.primary,
      centerTitle: true,
      titleTextStyle: getBoldStyle(
        color: XColors.neutral_9,
        fontSize: AppSize.s20,
      ),
      iconTheme: const IconThemeData(
        color: XColors.neutral_9,
      ),
    ),
  );
}
