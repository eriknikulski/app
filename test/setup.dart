import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/models/category_icon.dart';
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
        CategoryIcon.fromMap(config['categories']['harmless']),
        CategoryIcon.fromMap(config['categories']['delicate']),
        CategoryIcon.fromMap(config['categories']['offensive'])
      ]);
  assert(env != null);
}
