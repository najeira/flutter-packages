/// Utility class which contains useful static functions for dates.
class DateUtil {
  /// Returns `true` if [year] is leap year `false` if not.
  static bool isLeapYear(final int year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  /// Returns the number of days in a given month based on [year] and [month]

  static int daysInDate({int month, int year}) {
    if (month == 2) {
      if (year == null || isLeapYear(year)) {
        return 29;
      } else {
        return 28;
      }
    }

    if ((month == 4 || month == 6 || month == 9 || month == 11)) {
      return 30;
    }

    return 31;
  }

  static bool equalDays(int month1, int month2) {
    if (month1 == 2 && month2 == 2) {
      return true;
    } else if ((month1 == 4 || month1 == 6 || month1 == 9 || month1 == 11) &&
        (month2 == 4 || month2 == 6 || month2 == 9 || month2 == 11)) {
      return true;
    } else if ((month1 == 1 ||
            month1 == 3 ||
            month1 == 5 ||
            month1 == 7 ||
            month1 == 8 ||
            month1 == 10 ||
            month1 == 12) &&
        (month2 == 1 ||
            month2 == 3 ||
            month2 == 5 ||
            month2 == 7 ||
            month2 == 8 ||
            month2 == 10 ||
            month2 == 12)) {
      return true;
    }

    return false;
  }

  /// Fix [day] if it's greater than the days in the given [month] and [year]
  ///
  /// Example: (year: 2011, month: 2, day: 29)
  /// will be fixed to (year: 2010, month: 2, day: 28)
  static int fixDay({
    final int year,
    final int month,
    final int day,
  }) {
    if (day == null || month == null) {
      return day;
    } else {
      // month and day not null
      if (day >= 29 && month == 2 && year != null && isLeapYear(year)) {
        return 29;
      }
      // month and day not null
      // at this point year does not matter
      else if (day > 30 &&
          (month == 4 || month == 6 || month == 9 || month == 11)) {
        return 30;
      } else if (day > 28 && month == 2) {
        return 28;
      }
    }
    return day;
  }

  /// Checks if [year], [month] and [day] makes a valid date.
  /// Returns true if it does false if doesn't.
  static bool isValidDate({int year, int month, int day}) {
    if (year == null || month == null || day == null) {
      return false;
    }

    if (month < 1 || month > 12) {
      return false;
    }
    if (day < 1 || day > 31) {
      return false;
    }

    if (month == 2) {
      if (isLeapYear(year)) {
        return (day <= 29);
      } else {
        return (day <= 28);
      }
    }

    if (month == 4 || month == 6 || month == 9 || month == 11) {
      return (day <= 30);
    }

    return true;
  }

  /// Checks if [year], [month] and [day] makes a valid date.
  ///
  /// [year], [month] and/or [day] can be null.
  static bool isNullableValidDate({int year, int month, int day}) {
    if (month != null && (month < 1 || month > 12)) {
      return false;
    }

    if (day != null && (day < 1 || day > 31)) {
      return false;
    }

    if (month != null && month == 2) {
      if (year == null || isLeapYear(year)) {
        return (day == null || day <= 29);
      } else {
        return (day == null || day <= 28);
      }
    }

    if (month != null &&
        (month == 4 || month == 6 || month == 9 || month == 11)) {
      return (day == null || day <= 30);
    }

    return true;
  }
}
