import 'package:flutter/material.dart';
import 'package:zentry/src/features/appearance/domain/enums/season.dart';

class SeasonThemes {
  static final Map<Season, ThemeData> themes = {
    Season.spring: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.green[400],
      scaffoldBackgroundColor: Colors.green[50],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.green,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.pinkAccent,
      ),
    ),
    Season.summer: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.orange[400],
      scaffoldBackgroundColor: Colors.yellow[50],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.orange,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.blueAccent,
      ),
    ),
    Season.autumn: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.brown[400],
      scaffoldBackgroundColor: Colors.orange[50],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.brown,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.deepOrange,
      ),
    ),
    Season.winter: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue[400],
      scaffoldBackgroundColor: Colors.blueGrey[50],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.white,
      ),
    ),
  };
}
