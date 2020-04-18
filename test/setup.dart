import 'dart:convert' show json;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;

import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';

defaultSetup() async {
  WidgetsFlutterBinding.ensureInitialized();

  String raw = await rootBundle.loadString('lib/config.json');
  Map config = json.decode(raw);

  BuildEnvironment.init(
      flavor: BuildFlavor.development,
      baseUrl: config['dev']['baseUrl'] as String,
      defaultStatement: Statement.fromMap(config['defaultStatement']),
      errorStatement: Statement.fromMap(config['errorStatement']),
      categories: [
        Category.fromMap(config['categories']['harmless']),
        Category.fromMap(config['categories']['delicate']),
        Category.fromMap(config['categories']['offensive'])
      ]);
  assert(env != null);
}
