import 'package:meta/meta.dart';

import '../src/date.dart';
import '../src/date_util.dart';

/// Valid nullable date class
@immutable
class NullableValidDate extends Date {
  /// Returns a [NullableValidDate] object if parameters are valid
  /// otherwise asserts an error.
  NullableValidDate({
    final int year,
    final int month,
    final int day,
  })  : assert(
          DateUtil.isNullableValidDate(
            year: year,
            month: month,
            day: DateUtil.fixDay(year: year, month: month, day: day),
          ),
        ),
        super(
          year: year,
          month: month,
          day: DateUtil.fixDay(year: year, month: month, day: day),
        );

  /// Creates a NullableValidDate with `null` year,month and day
  const NullableValidDate.nullDate()
      : super(
          year: null,
          month: null,
          day: null,
        );
}
