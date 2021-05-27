# DropdownDatePicker

Easy to use flutter package to get and set dates. The package builds DropdownButton widgets to set dates (year, month, day).

## Table of contents
* [Visual examples](#visual-example)
* [Date classes](#date-classes)
* [DropdownDatePicker widget](#dropdownDatePicker-widget)
* [Examples](#examples)
* [DateUtil class](#dateutil-class)

## Visual examples

![example](/uploads/cfe5083085b930ee5356d30aae368fc5/examples.png)

*Note: If image is not displayed, open the GitLab repository to see the example image.*

## Date classes

### ValidDate

Makes sure that the given date is valid. Asserts an error if not.
Params: year: int, month: int, day: int

Example:

```dart
ValidDate(year: 2010, month: 10, day: 12); // it is valid
ValidDate(year: null, month: 13, day: 11); // throws assertion because of the null year, and invalid month value
```

### NullableValidDate

This works just as `ValidDate` but it is allowed to have null year, month and/or day value. 

### Date

ValidDate and NullableValidDate is derived from this abstract class.

## DropdownDatePicker widget

### Required parameters

**firstDate:** The minimum date that can be selected.

**lastDate:** The maximum date that can be selected.

*Note: `firstDate` must be before `lastDate`.*

### Optional parameters

**initialDate:** It's default value is `NullableValidDate(year: null, month: null, day: null)`.
Which means that no date is selected initially. If this parameter is omitted a default hintText will be shown in their DropdownButton widgets.

Example:

```dart
initialDate: ValidDate(year: 2010, month: 10, day: 12); // make sure the date is between firstDate and lastDate
initialDate: NullableValidDate(year: null, month: 13, day: 11); // it also can be a NullableValidDate
```

*Note: By passing an initialDate make sure if it is a valid date and it must be between the range of first and last date. Else it will result an assertion error.*

**ascending:** Determines how the DropdownMenuItems will be built (In ascending or descending order).

**dateFormat:** By default it is `DateFormat.ymd`. Use `DateFormat.mdy` or `DateFormat.dmy` to change it.

**dateHint:** Set your own hintTexts for the DropdownButton's.

```dart
dateHint: DateHint(year: 'year', month: 'month', day: 'day'); // by default params are: 'yyyy', 'mm', 'dd',
```

**dropdownColor:** Overrides the default color of DropDownButton's DropdownMenuItems.

**textStyle:** Replaces the `DropdownButton`'s default `TextStyle`.

**underLine:** Replaces the `DropdownButton`'s default underLine Widget.

## Examples

The following example will create a DropdownDatePicker instance with only the required parameters.

```dart
final now = DateTime.now();

DropdownDatePicker(
  firstDate: ValidDate(year: now.year - 100, month: 1, day: 1),
  lastDate: ValidDate(year: now.year, month: now.month, day: now.month),
),
```

Passing optional parameters.

```dart
final datePicker = DropdownDatePicker(
  firstDate: ValidDate(year: 2005, month: 01, day: 01),
  lastDate: ValidDate(year: 2020, month: 12, day: 12),
  initialDate: NullableDate(year: 2010, month: null, day: 24),
  ascending: false,
  dateFormat: DateFormat.dmy,
  dateHint: DateHint(year: 'year', month: 'month', day: 'day'),
  dropdownColor: Colors.red,
  underLine: ... // instance of Widget
),
```

Retrieve datepicker instance values like this:

```dart
datePickerInstance
  ..firstDate
  ..lastDate
  ..currentDate
  ..dateFormat
  ..year
  ..month
  ..day
  ..getDate('/');
```

## DateUtil class:

* isLeapYear(year): bool
* daysInDate(month, year): int
* isValidDate(year, month, day): bool
* isNullableValidDate(year, month, day): bool
