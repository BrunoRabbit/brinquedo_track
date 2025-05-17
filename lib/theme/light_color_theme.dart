import 'package:brinquedo_track/theme/base_color.dart';
import 'package:flutter/material.dart';

class LightColorTheme implements BaseColorTheme {
  const LightColorTheme();
  
  @override
  Color get background => Colors.white;
  @override
  Color get text => Colors.black;
  @override
  Color get primary => Colors.blue;
}
