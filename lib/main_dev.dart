import 'dart:convert' show json;

import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiOverlayStyle, rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocSupervisor;

import 'blocs/simple_bloc_delegate.dart';
import 'env.dart';
import 'models/category.dart';
import 'models/statement.dart';
import 'screens/app.dart';
import 'theme/style.dart';

Future<void> main() async {
  debugPaintSizeEnabled = true;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: appTheme().scaffoldBackgroundColor,
    statusBarColor: appTheme().scaffoldBackgroundColor,
  ));

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
      ],
      maxPrefetchCalls: config['maxPrefetchCalls'],
      prefetchWaitTime: config['prefetchWaitTime'],);
  assert(env != null);

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(App());
}
