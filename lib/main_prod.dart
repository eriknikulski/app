import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' ;

import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/screens/app.dart';


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
