import 'package:flutter_test/flutter_test.dart';

import 'package:never_have_i_ever/models/category_name.dart';
import 'package:never_have_i_ever/models/statement.dart';

import '../setup.dart';

main() {
  defaultSetup();

  group('test statement object', () {
    test('right attributes', () {
      Statement statement = Statement(
          text: 'This is a test statement.',
          uuid: 'myuuid',
          category: CategoryName.harmless);

      assert(statement.text == 'This is a test statement.');
      assert(statement.uuid == 'myuuid');
      assert(statement.category == CategoryName.harmless);
    });

    test('category icon toString', () {
      Statement statement = Statement(
          text: 'This is a test statement.',
          uuid: 'myuuid',
          category: CategoryName.harmless);

      assert(statement.toString() ==
          'Statement { uuid: myuuid, text: This is a test statement., category: CategoryName.harmless }');
    });

    test('statement comparison', () {
      Statement statement1 = Statement(
          text: 'This is a test statement.',
          uuid: 'myuuid',
          category: CategoryName.harmless);

      Statement statement2 = Statement(
          text: 'This is a test statement.',
          uuid: 'myuuid',
          category: CategoryName.harmless);

      assert(statement1 == statement2);
    });
  });
}
