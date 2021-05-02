import 'package:flutter/material.dart';

class Constants {
  Constants.empty();

  /*
  TEXT STYLES
  */
  static const TextStyle boldHeadlineStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );

  static const TextStyle whiteBoldSubheadlineStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle blackBoldNormal = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle boldSubheadlineStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const headlineStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 27,
  );

  static const miniheadlineStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 21,
    color: Colors.black,
  );

  static const subheadlineStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  static const drawerItemStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: Colors.black,
    letterSpacing: 0.3,
  );

  static const buttonStyle = TextStyle(
    color: Colors.white,
    letterSpacing: 0.5,
    fontWeight: FontWeight.bold,
    fontSize: 22,
  );

  static const normalWhite = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: .2,
  );

  static const headlineWhite = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const subHeadlineWhite = TextStyle(
    color: Colors.white,
    fontSize: 21,
    fontWeight: FontWeight.bold,
  );

  static const subtitleWhite = TextStyle(
    color: Colors.white,
    fontSize: 15,
  );

  /*
  BORDERS
  */
  static const InputBorder blackInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  );

  /*
  SIZING
  */
  static const double padding = 20;
  static const double avatarRadius = 45;

  /*
  DECORATIONS
  */
  static BoxDecoration kBoxDecorationStyle = BoxDecoration(
    color: Colors.grey[100],
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}
