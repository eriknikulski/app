import 'package:meta/meta.dart';

import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';

enum BuildFlavor { production, development, staging }

BuildEnvironment get env => _env;
BuildEnvironment _env;

class BuildEnvironment {
  final String baseUrl;
  final BuildFlavor flavor;
  final Statement defaultStatement;
  final Statement errorStatement;
  final List<Category> categories;

  BuildEnvironment._init(
      {this.flavor,
      this.baseUrl,
      this.defaultStatement,
      this.errorStatement,
      this.categories});

  static void init(
          {@required flavor,
          @required baseUrl,
          @required defaultStatement,
          @required errorStatement,
          @required categories}) =>
      _env ??= BuildEnvironment._init(
          flavor: flavor,
          baseUrl: baseUrl,
          defaultStatement: defaultStatement,
          errorStatement: errorStatement,
          categories: categories);
}
