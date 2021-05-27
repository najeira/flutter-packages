import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Instantiate valid date.', () {
    final date = ValidDate(year: 2010, month: 5, day: 10);

    expect(date.year, 2010);
    expect(date.month, 5);
    expect(date.day, 10);
  });

  test('Instantiate invalid date throws Assertion error.', () {
    expect(
        () => ValidDate(year: 2010, month: 12, day: 32), throwsAssertionError);
  });

  test('Instantiate valid date and test copyWith function.', () {
    final date = ValidDate(year: 2012, month: 4, day: 12);
    final copyWithdate = date.copyWith(year: 2010);

    expect(copyWithdate.year, 2010);
    expect(copyWithdate.month, 4);
    expect(copyWithdate.day, 12);

    final copyWithdate2 = copyWithdate.copyWith(year: 1999, month: 6, day: 24);

    expect(copyWithdate2.year, 1999);
    expect(copyWithdate2.month, 6);
    expect(copyWithdate2.day, 24);
  });
}
