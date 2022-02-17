import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

/// Defines a common __DatabaseUtil__ class
///
/// To `initialize` the local database and `register` the auto generated adapter.
class DatabaseUtil {
  /// Creates a path to a directory where the application may place data that is user-generated
  static Future<void> initDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  ///  Register our auto generated Adapter to our Hive database
  static void registerAdapter<Type>(TypeAdapter<Type> adapter) {
    try {
      Hive.registerAdapter(adapter);
    } on HiveError catch (error) {
      debugPrint(error.toString());
    }
  }
}
