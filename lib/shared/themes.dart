import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color primaryColor = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);
class Themes{
  static final light = ThemeData(
     backgroundColor:Colors.white,
      primaryColor: primaryColor,
      brightness: Brightness.light,
      appBarTheme:const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
      ),
  );
  static final dark = ThemeData(
   backgroundColor: darkGreyClr,
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,


  );
}
TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle:const TextStyle(
      fontWeight: FontWeight.bold,
      color:Colors.black,

      //color: Get.isDarkMode?Colors.white:Colors.black,
      fontSize:20,
    ),
  );
}
TextStyle get headingStyle{
  return GoogleFonts.lato(
    textStyle:const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize:30,
    ),
  );
}
TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle:const TextStyle(
      // color:Colors.black,
      fontWeight: FontWeight.w400,
      fontSize:16,
    ),
  );
}
TextStyle get subTitleStyle{
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      // color:Colors.black,
      fontWeight: FontWeight.w400,
      fontSize:14,
    ),
  );
}