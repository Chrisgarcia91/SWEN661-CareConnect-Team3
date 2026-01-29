import 'package:flutter/material.dart';

class AppTypography {
  static const FontWeight normal = FontWeight.w400;   //400
  static const FontWeight medium = FontWeight.w500;   //500
  static const FontWeight semibold = FontWeight.w600; //used in spec examples
  static const FontWeight bold = FontWeight.w700;     //used in headers

  static const double lh = 1.5;

  //Tailwind scale (px)
  static const double xs = 12;
  static const double sm = 14;
  static const double base = 16;
  static const double lg = 18;
  static const double xl = 20;
  static const double x2l = 24;
  static const double x3l = 30;

  static const TextStyle h1 = TextStyle(fontSize: x2l, fontWeight: medium, height: lh);
  static const TextStyle h2 = TextStyle(fontSize: xl, fontWeight: medium, height: lh);
  static const TextStyle h3 = TextStyle(fontSize: lg, fontWeight: medium, height: lh);
  static const TextStyle h4 = TextStyle(fontSize: base, fontWeight: medium, height: lh);

  static const TextStyle body = TextStyle(fontSize: base, fontWeight: normal, height: lh);
  static const TextStyle bodysm = TextStyle(fontSize: sm, fontWeight: normal, height: lh);
  static const TextStyle caption = TextStyle(fontSize: xs, fontWeight: medium, height: lh);

  static const TextStyle label = TextStyle(fontSize: base, fontWeight: medium, height: lh);
  static const TextStyle button = TextStyle(fontSize: base, fontWeight: medium, height: lh);
  static const TextStyle input = TextStyle(fontSize: base, fontWeight: normal, height: lh);
}