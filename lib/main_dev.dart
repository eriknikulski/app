import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:never_have_i_ever/blocs/simple_bloc_delegate.dart';
import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/models/category_icon.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/screens/app.dart';

Future<void> main() async {
  debugPaintSizeEnabled = true;

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

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(App());
}
