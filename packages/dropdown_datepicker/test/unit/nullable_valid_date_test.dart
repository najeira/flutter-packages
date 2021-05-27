import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Non-null valid date.', () {
    final date = NullableValidDate(year: 2010, month: 5, day: 10);
    expect(date.year, 2010);
    expect(date.month, 5);
    expect(date.day, 10);

    final date2 = NullableValidDate(year: 2019, month: 2, day: 28);
    expect(date2.year, 2019);
    expect(date2.month, 2);
    expect(date2.day, 28);
  });

  test('No paramters.', () {
    final date = NullableValidDate();

    expect(date.year, null);
    expect(date.month, null);
    expect(date.day, null);
  });

  test('Null parameters.', () {
    final date = NullableValidDate(year: null, month: null, day: null);

    expect(date.year, null);
    expect(date.month, null);
    expect(date.day, null);
  });

  test('Invalid date throws Assertion error.', () {
    expect(() => NullableValidDate(year: 2010, month: 12, day: 32),
        throwsAssertionError);
  });

  test('Valid date and copyWith function.', () {
    final date = NullableValidDate(year: 2012, month: 4, day: 12);
    final copyWithdate = date.copyWith(year: 2010);

    expect(copyWithdate.year, 2010);
    expect(copyWithdate.month, 4);
    expect(copyWithdate.day, 12);

    final copyWithdate2 = copyWithdate.copyWith(year: 1999, month: 6, day: 24);

    expect(copyWithdate2.year, 1999);
    expect(copyWithdate2.month, 6);
    expect(copyWithdate2.day, 24);
  });

  test('copyWith function tests:.', () {
    final date = NullableValidDate(year: 2012, month: null, day: 12);
    final copyWithdate = date.copyWith(year: 2010);

    expect(copyWithdate.year, 2010);
    expect(copyWithdate.month, null);
    expect(copyWithdate.day, 12);

    final copyWithdate2 = copyWithdate.copyWith(year: 1999, month: 6, day: 24);

    expect(copyWithdate2.year, 1999);
    expect(copyWithdate2.month, 6);
    expect(copyWithdate2.day, 24);

    final copyWithdate3 = copyWithdate2.copyWith(year: null, month: 6, day: 11);

    expect(copyWithdate3.year, 1999);
    expect(copyWithdate3.month, 6);
    expect(copyWithdate3.day, 11);

    final copyWithdate4 = copyWithdate3.copyWith(year: null, month: 6, day: 94);
    expect(copyWithdate4.day, 30);
  });
}
