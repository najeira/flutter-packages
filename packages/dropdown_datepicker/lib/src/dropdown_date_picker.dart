import 'package:flutter/material.dart';

import 'date.dart';
import 'date_format.dart';
import 'date_separator.dart';
import 'date_util.dart';
import 'nullable_valid_date.dart';

/// Creates a [DropdownDatePicker] widget instance
///
/// Displays year, month and day [DropdownButton] widgets in a [Row]
class DropdownDatePicker extends StatefulWidget {
  /// Creates an instance of [DropdownDatePicker].
  ///
  /// [firstYear] must be before [lastYear]
  /// and [initialDate] must be between their range.
  ///
  /// By default [dateFormat] is [DateFormat.ymd].
  const DropdownDatePicker({
    Key? key,
    this.firstYear = 1900,
    this.lastYear = 2999,
    this.initialDate = const NullableValidDate.nullDate(),
    this.dateFormat = DateFormat.ymd,
    this.textStyle,
    this.dropdownColor,
    this.underline = const _Underline(),
    this.separator,
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

  /// The background color of the dropdown.
  ///
  /// If it is not provided, the theme's [ThemeData.canvasColor] will be used
  /// instead.
  final Color? dropdownColor;

  /// The widget to use for drawing the drop-down button's underline.
  ///
  /// Defaults to a 1.0 height bottom container with Theme.of(context).dividerColor
  final Widget? underline;

  /// 
  final DateSeparator? separator;

  @override
  DropdownDatePickerState createState() => DropdownDatePickerState();
}

class DropdownDatePickerState extends State<DropdownDatePicker> {
  Date? _currentDate;

  void _setCurrentDate(Date date) {
    if (_currentDate != date) {
      setState(() {
        _currentDate = date;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxDay = DateUtil.daysInDate(
      month: currentDate.month,
      year: currentDate.year,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _DropdownMenuButton(
          value: currentDate.year,
          textStyle: widget.textStyle,
          dropdownColor: widget.dropdownColor,
          underline: widget.underline,
          onChanged: (int? value) {
            _setCurrentDate(NullableValidDate(
              year: value,
              month: month,
              day: day,
            ));
          },
          items: _buildDropdownMenuItemList(
            widget.firstYear,
            widget.lastYear,
            false,
          ),
        ),
        if (widget.separator != null)
          Text(
            widget.separator!.year,
            style: theme.textTheme.caption,
          ),
        const SizedBox(width: 12.0),
        _DropdownMenuButton(
          value: currentDate.month,
          textStyle: widget.textStyle,
          dropdownColor: widget.dropdownColor,
          underline: widget.underline,
          onChanged: (int? value) {
            _setCurrentDate(NullableValidDate(
              year: year,
              month: value,
              day: day,
            ));
          },
          items: _buildDropdownMenuItemList(1, 12, true),
        ),
        if (widget.separator != null)
          Text(
            widget.separator!.month,
            style: theme.textTheme.caption,
          ),
        const SizedBox(width: 12.0),
        _DropdownMenuButton(
          value: currentDate.day,
          textStyle: widget.textStyle,
          dropdownColor: widget.dropdownColor,
          underline: widget.underline,
          onChanged: (int? value) {
            _setCurrentDate(NullableValidDate(
              year: year,
              month: month,
              day: value,
            ));
          },
          items: _buildDropdownMenuItemList(1, maxDay, true),
        ),
        if (widget.separator != null)
          Text(
            widget.separator!.day,
            style: theme.textTheme.caption,
          ),
      ],
    );
  }
}

class _DropdownMenuButton extends StatelessWidget {
  const _DropdownMenuButton({
    Key? key,
    this.value,
    this.textStyle,
    this.dropdownColor,
    this.underline,
    this.onChanged,
    required this.items,
  }) : super(key: key);

  final int? value;

  final TextStyle? textStyle;

  final Color? dropdownColor;

  final Widget? underline;

  final ValueChanged<int?>? onChanged;

  final List<DropdownMenuItem<int?>> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mergedStyle = theme.textTheme.subtitle1!.merge(textStyle);
    return DropdownButton<int?>(
      style: mergedStyle,
      underline: underline,
      value: value,
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
              i?.toString().padLeft(2, '0') ?? '',
            ),
          ),
        ),
      )
      .toList();
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
