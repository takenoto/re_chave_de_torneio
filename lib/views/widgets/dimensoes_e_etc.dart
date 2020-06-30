//Dimensões padrão para uso nos negócios:
//Dimensões do competidor:
import 'package:flutter/material.dart';

double competidorHeight = 60.0;
double competidorWidth = 120.0;
const double strokeWidth = 5;
const double defaultSpacing = 15;
//const double defaultLargeSpacing = 40;
const double defaultLargeSpacing = 30;
const double strokeLineSize = 15;
const Color strokeColor = Colors.grey;
Color competidorWinnerColor = Colors.lightGreen;
const Color competidorLoserColor = Colors.grey;

ThemeData myThemeData = ThemeData(
  primarySwatch: Colors.amber,
  accentColor: Colors.white,
  backgroundColor: Colors.blueGrey[900],
);

TextStyle textoDestaque =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 24);

TextStyle helperStyle = TextStyle(color: myThemeData.primaryColor);
