import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:never_have_i_ever/blocs/simple_bloc_delegate.dart';
import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/screens/app.dart';

void main() {
  debugPaintSizeEnabled = true;
  BuildEnvironment.init(
      flavor: BuildFlavor.development,
      baseUrl: 'https://api.neverhaveiever.io/v1',
      maxApiCallTries: 50);
  assert(env != null);

  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(App());
}
