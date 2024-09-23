import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/core/databases/database.dart';

import 'presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  runApp(const App());
}

Future<void> _initHive() async {
  await Hive.initFlutter('task');
  await Database.init();
}
