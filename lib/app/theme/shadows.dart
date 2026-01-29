import 'package:flutter/material.dart';

class AppShadows {
  //shadow-sm 0 1px 2px 0 rgb (0 0 0 / 0.05)
  static const List<BoxShadow> sm = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
      color: Color(0x0D000000), // ~5% black
    ),
  ];

  //shadow-md-ish 0 4px 6px -1px rgb (0 0 0 / 0.1)
  static const List<BoxShadow> md = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
      color: Color(0x1A000000), //~10% black
    ),
  ];
}