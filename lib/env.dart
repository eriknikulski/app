import 'package:meta/meta.dart';

enum BuildFlavor { production, development, staging }

BuildEnvironment get env => _env;
BuildEnvironment _env;

class BuildEnvironment {
  final String baseUrl;
  final BuildFlavor flavor;
  final int maxApiCallTries;

  BuildEnvironment._init({this.flavor, this.baseUrl, this.maxApiCallTries});

  static void init(
          {@required flavor, @required baseUrl, @required maxApiCallTries}) =>
      _env ??= BuildEnvironment._init(
          flavor: flavor, baseUrl: baseUrl, maxApiCallTries: maxApiCallTries);
}
