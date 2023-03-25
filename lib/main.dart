import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'royal_stag.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(RoyalStag());
  });
}
