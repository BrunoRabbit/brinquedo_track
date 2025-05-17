import 'package:brinquedo_track/theme/base_color.dart';
import 'package:flutter/material.dart';

class DarkColorTheme implements BaseColorTheme {
  const DarkColorTheme();
  
  @override
  Color get background => Colors.white;
  @override
  Color get text => Colors.black;
  @override
  Color get primary => Colors.blue;
}
