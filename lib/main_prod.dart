import 'package:flutter/material.dart';

import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/screens/app.dart';

void main() {
  BuildEnvironment.init(
      flavor: BuildFlavor.production,
      baseUrl: 'https://api.neverhaveiever.io/v1');
  assert(env != null);

  runApp(App());
}
