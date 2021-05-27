import 'package:meta/meta.dart';
import '../src/date.dart';
import '../src/date_util.dart';

/// Valid non-nullable date class
@immutable
class ValidDate extends Date {
  /// Returns a [Date] object if parameters are valid
  /// otherwise asserts an error.
  ValidDate({
    @required int year,
    @required int month,
    @required int day,
  })  : assert(DateUtil.isValidDate(year: year, month: month, day: day)),
        super(
          year: year,
          month: month,
          day: DateUtil.fixDay(year: year, month: month, day: day),
        );
}
