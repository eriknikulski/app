import 'package:never_have_i_ever/env.dart';

defaultSetup() {
  BuildEnvironment.init(
      flavor: BuildFlavor.development,
      baseUrl: 'https://api.neverhaveiever.io/v1');
  assert(env != null);
}