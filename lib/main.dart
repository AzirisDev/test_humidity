import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyla_humidity/core/app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarBrightness: Brightness.dark),
  );
  runApp(const App());
}
