import 'package:meta/meta.dart';

enum BuildFlavor { production, development, staging }

BuildEnvironment get env => _env;
BuildEnvironment _env;

class BuildEnvironment {
  final String baseUrl;
  final BuildFlavor flavor;

  BuildEnvironment._init({this.flavor, this.baseUrl});

  static void init({@required flavor, @required baseUrl}) =>
      _env ??= BuildEnvironment._init(flavor: flavor, baseUrl: baseUrl);
}