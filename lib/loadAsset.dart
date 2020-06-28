import 'dart:async';
import 'package:flutter/services.dart';

Future<String> loadAsset(String path) async {
  return await rootBundle.loadString(path);
}
