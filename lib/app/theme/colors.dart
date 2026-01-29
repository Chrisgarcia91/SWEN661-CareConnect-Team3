import 'package:flutter/material.dart';

class AppColors {
  //----------LIGHT----------
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFFFFFFF); //card and popover
  static const inputBackground = Color(0xFFF3F3F5);

  //ok1ch(0.145 0 0) ~ very dark neutral
  static const foreground = Color(0xFF0A0A0A);

  static const muted = Color(0xFFECECF0);
  static const mutedForeground = Color(0xFF717182);
  static const accent = Color(0xFFE9EBEF);
  static const accentForeground = Color(0xFF030213);

  //Brand
  static const primary = Color(0xFF030213);
  static const onPrimary = Color(0xFFFFFFFF);

  //ok1ch(0.95 0.0058 264.53) = very light bluish tint
  static const secondary = Color(0xFFECEEF2);
  static const onSecondary = Color(0xFF030213);

//Borders/ring
static const border = Color(0x1A000000); //rgba (0,0,0,0.1)
static const ring = Color(0xFFA1A1A1);

//Switch
static const switchOff = Color(0xFFCBCED4);
static const switchOn = primary;

//Destructive
static const destructive = Color(0xFFD4183D);
static const onDestructive = Color(0xFFFFFFFF);

//App-specific action colors
static const blue600 = Color(0xFF2563EB);
static const blue700 = Color(0xFF1D4ED8);
static const green600 = Color(0xFF16A34A);
static const purple600 = Color(0xFF9333EA);

static const orange50 = Color(0xFFFFF7ED);
static const orange600 = Color(0xFFEA580C);
static const green700 = Color(0xFF15803D);

// Grays
static const gray50 = Color(0xFFF9FAFB);
static const gray100 = Color(0xFFF3F4F6);
static const gray200 = Color(0xFFE5E7EB);
static const gray400 = Color(0xFF9CA3AF);
static const gray500 = Color(0xFF6B7280);
static const gray600 = Color(0xFF4B5563);
static const gray700 = Color(0xFF374151);
static const gray900 = Color(0xFF111827);

//----------DARK----------
static const backgroundDark = Color(0xFF0A0A0A);  //ok1ch(0.145 0 0)
static const foregroundDark = Color(0xFFFAFAFA);  //ok1ch(0.985 0 0)
static const surfaceDark = Color(0xFF0A0A0A);

static const secondaryDark = Color(0xFF262626);   //ok1ch(0.269 0 0)
static const onSecondaryDark = Color(0xFFFAFAFA);

static const mutedDark = Color(0xFF262626);
static const mutedForegroundDark = Color(0xFFA1A1A1); //ok1ch(0.708 0 0)

static const accentDark = Color(0xFF262626);
static const onAccentDark = Color(0xFFFAFAFA);

static const borderDark = Color(0xFF262626);
static const ringDark = Color(0xFF525252);    //ok1ch(0.439 0 0)

//Dark mode brand where primary becomes light
static const primaryDark = Color(0xFFFAFAFA);
static const onPrimaryDark = Color(0xFF171717); //ok1ch(0.205 0 0)

//Sidebar dark token
static const sidebarDark = Color(0xFF171717);

//Dark destructive
static const destructiveDark = Color(0xFF82181A);
static const onDestructiveDark = Color(0xFFFB2C36);

}