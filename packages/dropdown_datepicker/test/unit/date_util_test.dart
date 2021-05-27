import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isValidDate tests:', () {
    test('2010-05-11', () {
      expect(DateUtil.isValidDate(year: 2010, month: 5, day: 11), true);
    });

    test('2015-12-32', () {
      expect(DateUtil.isValidDate(year: 2010, month: 12, day: 31), true);
    });

    test('2020-02-29', () {
      expect(DateUtil.isValidDate(year: 2010, month: 12, day: 31), true);
    });

    test('2019-02-29', () {
      expect(DateUtil.isValidDate(year: 2010, month: 2, day: 29), false);
    });

    test('2020-01-01', () {
      expect(DateUtil.isValidDate(year: 2010, month: 12, day: 31), true);
    });

    test('2020-04-30', () {
      expect(DateUtil.isValidDate(year: 2010, month: 4, day: 30), true);
    });

    test('2020-04-31', () {
      expect(DateUtil.isValidDate(year: 2010, month: 4, day: 31), false);
    });
  });

  group('isNullableValidDate tests:', () {
    test('2010-05-11', () {
      expect(DateUtil.isNullableValidDate(year: 2010, month: 5, day: 11), true);
    });

    test('2015-12-32', () {
      expect(
          DateUtil.isNullableValidDate(year: 2010, month: 12, day: 31), true);
    });

    test('2020-02-29', () {
      expect(
          DateUtil.isNullableValidDate(year: 2010, month: 12, day: 31), true);
    });

    test('2019-02-29', () {
      expect(
          DateUtil.isNullableValidDate(year: 2010, month: 2, day: 29), false);
    });

    test('2020-01-01', () {
      expect(
          DateUtil.isNullableValidDate(year: 2010, month: 12, day: 31), true);
    });

    test('2020-04-30', () {
      expect(DateUtil.isNullableValidDate(year: 2010, month: 4, day: 30), true);
    });

    test('2020-04-31', () {
      expect(
          DateUtil.isNullableValidDate(year: 2010, month: 4, day: 31), false);
    });

    test('null-null-null', () {
      expect(DateUtil.isNullableValidDate(year: null, month: null, day: null),
          true);
    });

    test('null-2-29', () {
      expect(DateUtil.isNullableValidDate(year: null, month: 2, day: 29), true);
    });

    test('null-2-null', () {
      expect(
          DateUtil.isNullableValidDate(year: null, month: 2, day: null), true);
    });

    test('null-4-null', () {
      expect(
          DateUtil.isNullableValidDate(year: null, month: 4, day: null), true);
    });

    test('null-4-31', () {
      expect(
          DateUtil.isNullableValidDate(year: null, month: 4, day: 31), false);
    });

    test('null-12-null', () {
      expect(
          DateUtil.isNullableValidDate(year: null, month: 12, day: null), true);
    });

    test('2019-12-null', () {
      expect(
          DateUtil.isNullableValidDate(year: 2019, month: 12, day: null), true);
    });

    test('2019-12-null', () {
      expect(
          DateUtil.isNullableValidDate(year: 2019, month: 12, day: null), true);
    });
  });
}
