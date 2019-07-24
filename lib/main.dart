import 'package:budget/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:budget/util/budgeter_colors.dart';

void main() => runApp(App());

/// This Widget is the main application widget.
class App extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  final ThemeData _baseThemeData = ThemeData.light();
  TextTheme _baseTextTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Home(),
      theme: _buildLightTheme(),
    );
  }

  ThemeData _buildLightTheme() {
    _baseTextTheme = _baseThemeData.textTheme;
    return _baseThemeData.copyWith(
        primaryColor: BudgeterColors.navy,
        accentColor: BudgeterColors.teal,
        scaffoldBackgroundColor: Colors.grey[300],
        cardColor: Colors.grey[400],
        canvasColor: Colors.grey[400],
        buttonColor: BudgeterColors.navy,
        floatingActionButtonTheme: _buidlFloatingActionButtonThemeData(),
        textTheme: _buildTextTheme(BudgeterColors.white));
  }

  FloatingActionButtonThemeData _buidlFloatingActionButtonThemeData() {
    return FloatingActionButtonThemeData(
        backgroundColor: BudgeterColors.navy,
        shape: BeveledRectangleBorder(
            borderRadius:
                BorderRadius.horizontal(
                  right: Radius.elliptical(30, 50),
                  left: Radius.elliptical(8, 20))));
  }

  TextTheme _buildTextTheme(Color color) {
    return _baseTextTheme
        .copyWith(
            headline:
                _baseTextTheme.headline.copyWith(fontWeight: FontWeight.w500))
        .apply(fontFamily: 'Rubnik', displayColor: color, bodyColor: color);
  }
}
