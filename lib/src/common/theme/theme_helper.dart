import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeHelper {
  static Color white = const Color(0xffFFFFFF);
  static Color black = const Color(0xff000000);
  static Color primaryColor = const Color(0xff0c54be);
  static Color darkPrimaryColor = const Color(0xff303f60);
  static Color lightGrey = const Color(0xffced3dc);
  static Color bgColor = Color.fromARGB(255, 212, 226, 240);

  static TextStyle appHeadingTextStyle = TextStyle(
      color: primaryColor,
      fontSize: 24,
      fontFamily: GoogleFonts.encodeSansExpanded(fontWeight: FontWeight.bold)
          .fontFamily);
  static TextStyle authTextFieldTextStyle = TextStyle(
      color: darkPrimaryColor,
      fontSize: 16,
      fontFamily: GoogleFonts.encodeSansExpanded(fontWeight: FontWeight.w500)
          .fontFamily);
  static TextStyle authMediumTextStyle = TextStyle(
      color: darkPrimaryColor,
      fontSize: 16,
      fontFamily: GoogleFonts.encodeSansExpanded(fontWeight: FontWeight.w500)
          .fontFamily);
  static TextStyle authBoldTextStyle = TextStyle(
      color: primaryColor,
      fontSize: 16,
      fontFamily: GoogleFonts.encodeSansExpanded(fontWeight: FontWeight.bold)
          .fontFamily);
  static TextStyle buttonTextStyle = TextStyle(
      color: white,
      fontSize: 18,
      fontFamily: GoogleFonts.encodeSansExpanded(fontWeight: FontWeight.bold)
          .fontFamily);
  static TextStyle appBarBoldTextStyle = TextStyle(
      color: white,
      fontSize: 16,
      fontFamily: GoogleFonts.encodeSansExpanded(fontWeight: FontWeight.bold)
          .fontFamily);
  static TextStyle headingBoldTextStyle = TextStyle(
      color: black,
      fontSize: 16,
      fontFamily: GoogleFonts.encodeSansExpanded(fontWeight: FontWeight.bold)
          .fontFamily);
  static TextStyle subheadingMediumTextStyle = TextStyle(
      color: black,
      fontSize: 16,
      fontFamily: GoogleFonts.encodeSansExpanded(fontWeight: FontWeight.w500)
          .fontFamily);
  static TextStyle smallTextStyle = TextStyle(
      color: lightGrey,
      fontSize: 14,
      fontFamily: GoogleFonts.encodeSansExpanded().fontFamily);

  static InputDecoration whiteTextFieldDecoration = InputDecoration(
    hintStyle: authTextFieldTextStyle,
    fillColor: white,
    filled: true,
    isDense: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
