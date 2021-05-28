import 'package:dropdown_datepicker/dropdown_datepicker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Date base class toString with default parameters.', () {
    final date = ValidDate(year: 2010, month: 5, day: 1);
    expect(date.toString(), '2010-05-01');

    final date2 = ValidDate(year: 10, month: 11, day: 24);
    expect(date2.toString(), '0010-11-24');
  });

  test('Date base class toString with DateFormat.dmy and / separator', () {
    final date = ValidDate(year: 10, month: 11, day: 24);
    expect(date.toString(DateFormat.dmy, '/'), '24/11/0010');
  });

  test('Date base class toString with null values', () {
    final date = NullableValidDate(year: null, month: null);
    expect(date.toString(DateFormat.mdy, '/'), '00/00/0000');
  });

  group('Operator tests:', () {
    final date1 = ValidDate(year: 2013, month: 11, day: 24);
    final date2 = ValidDate(year: 2012, month: 1, day: 28);
    final date3 = ValidDate(year: 2012, month: 1, day: 28);
    final date4 = ValidDate(year: 2014, month: 12, day: 10);
    final date5 = ValidDate(year: 2018, month: 4, day: 4);
    final date6 = ValidDate(year: 2012, month: 1, day: 29);

    test('ValidDate >= operator tests', () {
      expect(date1 >= date2, true);
      expect(date2 >= date3, true);
      expect(date2 >= date2, true);
      expect(date2 >= date5, false);
      expect(date4 >= date5, false);
      expect(date1 >= date5, false);
      expect(date6 >= date2, true);
    });

    test('ValidDate > operator tests', () {
      expect(date1 > date2, true);
      expect(date2 > date3, false);
      expect(date2 > date2, false);
      expect(date2 > date5, false);
      expect(date4 > date5, false);
      expect(date1 > date5, false);
      expect(date6 > date2, true);
    });

    test('ValidDate <= operator tests', () {
      expect(date1 <= date2, false);
      expect(date2 <= date3, true);
      expect(date2 <= date2, true);
      expect(date2 <= date5, true);
      expect(date4 <= date5, true);
      expect(date1 <= date5, true);
      expect(date6 <= date2, false);
    });

    test('ValidDate < operator tests', () {
      expect(date1 < date2, false);
      expect(date2 < date3, false);
      expect(date2 < date2, false);
      expect(date2 < date5, true);
      expect(date4 < date5, true);
      expect(date1 < date5, true);
      expect(date6 < date2, false);
    });

    test('ValidDate == operator tests', () {
      expect(date1 == date2, false);
      expect(date2 == date3, true);
      expect(date2 == date5, false);
      expect(date1 == date1, true);
      expect(date4 == date5, false);
      expect(date1 == date5, false);
      expect(date6 == date2, false);
    });

    final date7 = NullableValidDate(year: null, month: null, day: 28);
    final date8 = NullableValidDate(year: null, month: null, day: 28);
    final date9 = NullableValidDate(year: null, month: null, day: null);
    final date10 = NullableValidDate(year: 2010, month: null, day: null);
    final date11 = NullableValidDate(year: 2010, month: 5, day: null);
    test('NullableDate >= operator tests', () {
      expect(date7 >= date8, true);
      expect(date7 >= date7, true);
      expect(date9 >= date7, false);
      expect(date10 >= date11, false);
      expect(date8 >= date11, false);
    });

    test('NullableDate > operator tests', () {
      expect(date7 > date8, false);
      expect(date7 > date7, false);
      expect(date9 > date7, false);
      expect(date10 > date11, false);
      expect(date8 > date11, false);
    });

    test('NullableDate <= operator tests', () {
      expect(date7 <= date8, true);
      expect(date7 <= date7, true);
      expect(date9 <= date7, true);
      expect(date10 <= date11, true);
      expect(date8 <= date11, true);
    });

    test('NullableDate < operator tests', () {
      expect(date7 < date8, false);
      expect(date7 < date7, false);
      expect(date9 < date7, true);
      expect(date10 < date11, true);
      expect(date8 < date11, true);
    });

    test('NullableDate == operator tests', () {
      expect(date7 == date8, true);
      expect(date7 == date7, true);
      expect(date9 == date7, false);
      expect(date10 == date11, false);
      expect(date8 == date11, false);
    });

    test('hasNull() tests', () {
      expect(date1.hasNull(), false);
      expect(date8.hasNull(), true);
      expect(date11.hasNull(), true);
    });
  });
}
