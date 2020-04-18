import 'dart:convert' show json;

import 'package:flutter/material.dart' show runApp, WidgetsFlutterBinding;
import 'package:flutter/services.dart' show rootBundle;

import 'env.dart';
import 'models/category.dart';
import 'models/statement.dart';
import 'screens/app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String raw = await rootBundle.loadString('lib/config.json');
  Map config = json.decode(raw);

  BuildEnvironment.init(
      flavor: BuildFlavor.production,
      baseUrl: config['prod']['baseUrl'] as String,
      defaultStatement: Statement.fromMap(config['defaultStatement']),
      errorStatement: Statement.fromMap(config['errorStatement']),
      categories: [
        Category.fromMap(config['categories']['harmless']),
        Category.fromMap(config['categories']['delicate']),
        Category.fromMap(config['categories']['offensive'])
      ]);
  assert(env != null);

  runApp(App());
}
