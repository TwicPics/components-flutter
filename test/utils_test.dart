import 'package:flutter_test/flutter_test.dart';
import 'package:twicpics_components/src/utils.dart';

void main() {
  group('getNumber', () {
    test('should return null as value is not a number', () {
      expect(getNumber('i am not a number'), null);
    });
    test('should return null as value is null', () {
      expect(getNumber(null), null);
    });

    test('should return cast "1000" to 1000', () {
      expect(getNumber('1000'), 1000);
    });

    test('should return 1000 as value = 1000', () {
      expect(getNumber(1000), 1000);
    });

    test('should return a double', () {
      expect(getNumber(1000.99), 1000.99);
    });

    test('should return a negative double', () {
      expect(getNumber('-1000.99'), -1000.99);
    });
  });

  test('should build error message ', () {
    expect(buildErrorMessage('i am not a number'),
        'twicpics-components i am not a number');
  });
}
