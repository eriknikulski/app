import 'package:meta/meta.dart' show required;

import 'package:nhie/models/category.dart';
import 'package:nhie/models/statement.dart';

enum BuildFlavor { production, development, staging }

BuildEnvironment get env => _env;
BuildEnvironment _env;

class BuildEnvironment {
  final String baseUrl;
  final BuildFlavor flavor;
  final Statement defaultStatement;
  final Statement errorStatement;
  final List<Category> categories;
  final int maxPrefetchCalls;
  final int prefetchWaitTime;
  final List<String> languageCodes;
  String selectedLanguage;

  BuildEnvironment._init(
      {this.flavor,
      this.baseUrl,
      this.defaultStatement,
      this.errorStatement,
      this.categories,
      this.maxPrefetchCalls,
      this.prefetchWaitTime,
      this.languageCodes,
      this.selectedLanguage});

  static void init(
          {@required flavor,
          @required baseUrl,
          @required defaultStatement,
          @required errorStatement,
          @required categories,
          @required maxPrefetchCalls,
          @required prefetchWaitTime,
          @required languageCodes,
          @required selectedLanguage}) =>
      _env ??= BuildEnvironment._init(
          flavor: flavor,
          baseUrl: baseUrl,
          defaultStatement: defaultStatement,
          errorStatement: errorStatement,
          categories: categories,
          maxPrefetchCalls: maxPrefetchCalls,
          prefetchWaitTime: prefetchWaitTime,
          languageCodes: languageCodes,
          selectedLanguage: selectedLanguage);
}
