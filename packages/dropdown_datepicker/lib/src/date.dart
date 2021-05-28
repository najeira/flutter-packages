import 'package:meta/meta.dart';

import '../src/date_format.dart';
import '../src/nullable_valid_date.dart';

@immutable
class _Date extends Date {
  const _Date({
    required int year,
    required int month,
    required int day,
  }) : super(year: year, month: month, day: day);
}

/// Base class for other date class objects
@immutable
abstract class Date {
  /// Base class for date objects
  const Date({this.year, this.month, this.day});

  final int? year;
  final int? month;
  final int? day;

  @override
  bool operator ==(Object other) {
    return other is Date && year == other.year && month == other.month && day == other.day;
  }

  @override
  int get hashCode => (year ?? 0) ^ (month ?? 0) ^ (day ?? 0);

  bool _greater(_Date nonNullDate, _Date other) {
    if (nonNullDate.year! < other.year!) {
      return true;
    }
    if (nonNullDate.year! > other.year!) {
      return false;
    }
    if (nonNullDate.month! < other.month!) {
      return true;
    }
    if (nonNullDate.month! > other.month!) {
      return false;
    }
    if (nonNullDate.day! < other.day!) {
      return true;
    }
    return false;
  }

  bool _smaller(_Date nonNullDate, _Date other) {
    if (nonNullDate.year! > other.year!) {
      return true;
    }
    if (nonNullDate.year! < other.year!) {
      return false;
    }
    if (nonNullDate.month! > other.month!) {
      return true;
    }
    if (nonNullDate.month! < other.month!) {
      return false;
    }
    if (nonNullDate.day! > other.day!) {
      return true;
    }
    return false;
  }

  _Date _convertDateValuesToZeroIfNull(Date date) {
    return _Date(
      year: date.year ?? 0,
      month: date.month ?? 0,
      day: date.day ?? 0,
    );
  }

  /// Checks if [year], [month] or [day] is null
  bool hasNull() {
    return year == null || month == null || day == null;
  }

  bool operator <=(Date other) {
    final nonNullThisDate = _convertDateValuesToZeroIfNull(this);
    final nonNullOtherDate = _convertDateValuesToZeroIfNull(other);
    if (nonNullThisDate == nonNullOtherDate) {
      return true;
    }
    return _greater(nonNullThisDate, nonNullOtherDate);
  }

  bool operator <(Date other) {
    final nonNullThisDate = _convertDateValuesToZeroIfNull(this);
    final nonNullOtherDate = _convertDateValuesToZeroIfNull(other);
    if (nonNullThisDate == nonNullOtherDate) {
      return false;
    }
    return _greater(nonNullThisDate, nonNullOtherDate);
  }

  bool operator >=(Date other) {
    final nonNullThisDate = _convertDateValuesToZeroIfNull(this);
    final nonNullOtherDate = _convertDateValuesToZeroIfNull(other);
    if (nonNullThisDate == nonNullOtherDate) {
      return true;
    }
    return _smaller(nonNullThisDate, nonNullOtherDate);
  }

  bool operator >(Date other) {
    final nonNullThisDate = _convertDateValuesToZeroIfNull(this);
    final nonNullOtherDate = _convertDateValuesToZeroIfNull(other);
    if (nonNullThisDate == nonNullOtherDate) {
      return false;
    }
    return _smaller(nonNullThisDate, nonNullOtherDate);
  }

  /// Concatenates [year], [month] and [day] by [dateFormat] with [separator]
  @override
  String toString([
    DateFormat dateFormat = DateFormat.ymd,
    String separator = '-',
  ]) {
    final year = (this.year ?? 0).toString().padLeft(4, '0');
    final month = (this.month ?? 0).toString().padLeft(2, '0');
    final day = (this.day ?? 0).toString().padLeft(2, '0');
    late String date;
    switch (dateFormat) {
      case DateFormat.ymd:
        date = '$year$separator$month$separator$day';
        break;
      case DateFormat.dmy:
        date = '$day$separator$month$separator$year';
        break;
      case DateFormat.mdy:
        date = '$month$separator$day$separator$year';
        break;
    }
    return date;
  }

  /// Returns a new [NullableValidDate] object with either the current values,
  /// or replacing those values with the ones passed in.
  Date copyWith({
    final int? year,
    final int? month,
    final int? day,
    final DateFormat? dateFormat,
  }) {
    return NullableValidDate(
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
    );
  }
}
