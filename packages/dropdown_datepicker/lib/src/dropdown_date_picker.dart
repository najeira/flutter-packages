import 'package:flutter/material.dart';

import 'date.dart';
import 'date_format.dart';
import 'date_hint.dart';
import 'date_util.dart';
import 'nullable_valid_date.dart';

/// Creates a [DropdownDatePicker] widget instance
///
/// Displays year, month and day [DropdownButton] widgets in a [Row]
class DropdownDatePicker extends StatefulWidget {
  /// Creates an instance of [DropdownDatePicker].
  ///
  /// [firstYear] must be before [lastYear]
  /// and [initialDate] must be between their range
  ///
  /// [initialDate] is optional, if not provided a hintText
  /// will be shown in their [DropDownButton]'s
  ///
  /// By default [dateFormat] is [DateFormat.ymd].
  const DropdownDatePicker({
    Key? key,
    this.firstYear = 1900,
    this.lastYear = 2999,
    this.initialDate = const NullableValidDate.nullDate(),
    this.dateFormat = DateFormat.ymd,
    this.dateHint = const DateHint(),
    this.textStyle,
    this.underline = const _Underline(),
    this.ascending = true,
  })  : assert(firstYear < lastYear, 'First year must be before last year.'),
        super(key: key);

  /// The date format how [DropdownButton] widgets should be build.
  final DateFormat dateFormat;

  /// Initial date value.
  final Date initialDate;

  /// Mimimum year value that [DropdownButton] widgets can have.
  final int firstYear;

  /// Maximum year value that [DropdownButton] widgets can have.
  final int lastYear;

  /// Text style of the dropdown button and it's menu items
  final TextStyle? textStyle;

  /// The widget to use for drawing the drop-down button's underline.
  ///
  /// Defaults to a 1.0 height bottom container with Theme.of(context).dividerColor
  final Widget? underline;

  /// If true [DropdownMenuItem]s will be built in ascending order
  final bool ascending;

  /// Contains year, month and day DropdownButton's hint texts
  ///
  /// Default is: 'yyyy', 'mm', 'dd'
  final DateHint dateHint;

  @override
  _DropdownDatePickerState createState() => _DropdownDatePickerState();
}

class _DropdownDatePickerState extends State<DropdownDatePicker> {
  Date? _currentDate;

  /// Holds the currently selected date
  Date get currentDate => _currentDate ?? widget.initialDate;

  /// Returns currently selected day
  int? get day {
    return currentDate.day;
  }

  /// Returns currently selected month
  int? get month {
    return currentDate.month;
  }

  /// Returns currently selected year
  int? get year {
    return currentDate.year;
  }

  /// Returns date as String by a [separator]
  /// based on [dateFormat]
  String getDate([String separator = '-']) {
    final date = currentDate;
    final year = date.year;
    final month = Date.toStringWithLeadingZeroIfLengthIsOne(date.month);
    final day = Date.toStringWithLeadingZeroIfLengthIsOne(date.day);
    switch (widget.dateFormat) {
      case DateFormat.ymd:
        return '$year$separator$month$separator$day';
      case DateFormat.dmy:
        return '$day$separator$month$separator$year';
      case DateFormat.mdy:
        return '$month$separator$day$separator$year';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxDay = DateUtil.daysInDate(
      month: currentDate.month,
      year: currentDate.year,
    );
    return Row(
      children: [
        _DropdownMenuButton<int?>(
          value: currentDate.year,
          textStyle: widget.textStyle,
          underline: widget.underline,
          hintText: widget.dateHint.year,
          onChanged: (int? value) {
            _currentDate = currentDate.copyWith(year: value);
          },
          items: _buildDropdownMenuItemList(
            widget.firstYear,
            widget.lastYear,
            false,
          ),
        ),
        Text(
          "年",
          style: theme.textTheme.caption,
        ),
        const SizedBox(width: 12.0),
        _DropdownMenuButton<int?>(
          value: currentDate.month,
          textStyle: widget.textStyle,
          underline: widget.underline,
          hintText: widget.dateHint.month,
          onChanged: (int? value) {
            _currentDate = currentDate.copyWith(month: value);
          },
          items: _buildDropdownMenuItemList(1, 12, true),
        ),
        Text(
          "月",
          style: theme.textTheme.caption,
        ),
        const SizedBox(width: 12.0),
        _DropdownMenuButton<int?>(
          value: currentDate.day,
          textStyle: widget.textStyle,
          underline: widget.underline,
          hintText: widget.dateHint.day,
          onChanged: (int? value) {
            _currentDate = currentDate.copyWith(day: value);
          },
          items: _buildDropdownMenuItemList(1, maxDay, true),
        ),
        Text(
          "日",
          style: theme.textTheme.caption,
        ),
      ],
    );
  }
}

class _DropdownMenuButton<T> extends StatelessWidget {
  const _DropdownMenuButton({
    Key? key,
    this.value,
    this.textStyle,
    this.hintText,
    this.underline,
    this.onChanged,
    this.items,
  }) : super(key: key);

  final T? value;

  final TextStyle? textStyle;

  final String? hintText;

  final Widget? underline;

  final ValueChanged<T?>? onChanged;

  final List<DropdownMenuItem<T>>? items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hintWidget = hintText != null
        ? Text(
            hintText!,
            style: TextStyle(
              color: theme.disabledColor,
            ),
          )
        : null;
    return DropdownButton<T>(
      style: textStyle,
      underline: underline,
      value: value,
      hint: hintWidget,
      onChanged: onChanged,
      items: items,
    );
  }
}

class _Underline extends StatelessWidget {
  const _Underline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.dividerColor,
      height: 1.0,
    );
  }
}

List<DropdownMenuItem<int?>> _buildDropdownMenuItemList(
    int min, int max, bool ascending) {
  return _intGenerator(min, max, ascending)
      .map(
        (i) => DropdownMenuItem<int?>(
          value: i,
          child: Center(
            child: Text(
              _toStringWithLeadingZeroIfLengthIsOne(i),
            ),
          ),
        ),
      )
      .toList();
}

String _toStringWithLeadingZeroIfLengthIsOne(int? i) {
  if (i == null || i < 0) {
    return '';
  }
  return Date.toStringWithLeadingZeroIfLengthIsOne(i);
}

Iterable<int?> _intGenerator(int start, int end, bool ascending) sync* {
  yield null;
  if (ascending) {
    for (var i = start; i <= end; i++) {
      yield i;
    }
  } else {
    for (var i = end; i >= start; i--) {
      yield i;
    }
  }
}
