import 'dart:convert' show json;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart' show TestWidgetsFlutterBinding;

import 'package:nhie/env.dart';
import 'package:nhie/models/category.dart';
import 'package:nhie/models/statement.dart';

defaultSetup() async {
  TestWidgetsFlutterBinding.ensureInitialized();

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
    ],
    maxPrefetchCalls: config['maxPrefetchCalls'],
    prefetchWaitTime: config['prefetchWaitTime'],
    languageCodes: config['languageCodes'].cast<String>(),
    selectedLanguage: config['selectedLanguage'],
  );
  assert(env != null);
}
