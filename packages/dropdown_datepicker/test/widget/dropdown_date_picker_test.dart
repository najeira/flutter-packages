import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'Create DropdownDatePicker with valid first/last and initial date',
      (tester) async {
    final dpdWidget = DropdownDatePicker(
      firstDate: ValidDate(year: 2005, month: 1, day: 1),
      lastDate: ValidDate(year: 2020, month: 12, day: 12),
      initialDate: NullableValidDate(year: 2007, month: 4, day: 11),
    );

    expect(dpdWidget.year, 2007);
    expect(dpdWidget.month, 4);
    expect(dpdWidget.day, 11);

    expect(dpdWidget.lastDate.year, 2020);
    expect(dpdWidget.lastDate.month, 12);
    expect(dpdWidget.lastDate.day, 12);

    expect(dpdWidget.firstDate.year, 2005);
    expect(dpdWidget.firstDate.month, 1);
    expect(dpdWidget.firstDate.day, 1);
  });

  testWidgets('Create DropdownDatePicker with valid first and last date',
      (tester) async {
    final dpdWidget = DropdownDatePicker(
      firstDate: ValidDate(year: 2005, month: 1, day: 1),
      lastDate: ValidDate(year: 2020, month: 12, day: 12),
    );

    expect(dpdWidget.year, null);
    expect(dpdWidget.month, null);
    expect(dpdWidget.day, null);

    expect(dpdWidget.lastDate.year, 2020);
    expect(dpdWidget.lastDate.month, 12);
    expect(dpdWidget.lastDate.day, 12);

    expect(dpdWidget.firstDate.year, 2005);
    expect(dpdWidget.firstDate.month, 1);
    expect(dpdWidget.firstDate.day, 1);
  });

  testWidgets('Create DropdownDatePicker first date after last date',
      (tester) async {
    expect(
        () => DropdownDatePicker(
              firstDate: ValidDate(year: 2020, month: 12, day: 12),
              lastDate: ValidDate(year: 2005, month: 1, day: 1),
            ),
        throwsAssertionError);
  });

  testWidgets(
      'Create DropdownDatePicker first date and last date with invalid initial date',
      (tester) async {
    expect(
        () => DropdownDatePicker(
              firstDate: ValidDate(year: 2005, month: 1, day: 2),
              lastDate: ValidDate(year: 2020, month: 12, day: 12),
              initialDate: NullableValidDate(year: 2005, month: 1, day: 1),
            ),
        throwsAssertionError);
  });

  testWidgets('with valid initial, first and last date params', (tester) async {
    final dpdWidget = DropdownDatePicker(
      firstDate: ValidDate(year: 2005, month: 01, day: 01),
      lastDate: ValidDate(year: 2020, month: 12, day: 12),
      initialDate: NullableValidDate(year: 2007, month: 4, day: 11),
    );

    final appWidget = MaterialApp(
      home: Scaffold(
        body: dpdWidget,
      ),
    );

    await tester.pumpWidget(appWidget);
    await tester.pump();

    expect(find.byType(DropdownDatePicker), findsOneWidget);

    final yearFinder = find.text('2005');
    final yearFinder2 = find.text('2020');
    final dayFinder = find.text('31');

    expect(yearFinder, findsOneWidget);
    expect(yearFinder2, findsOneWidget);
    expect(dayFinder, findsNothing);

    expect(dpdWidget.year, 2007);
  });

  testWidgets('with valid first and last date param but null initial date',
      (tester) async {
    final widget = MaterialApp(
      home: Scaffold(
        body: DropdownDatePicker(
          firstDate: ValidDate(year: 2005, month: 01, day: 01),
          lastDate: ValidDate(year: 2020, month: 12, day: 12),
        ),
      ),
    );

    await tester.pumpWidget(widget);

    expect(find.byType(DropdownDatePicker), findsOneWidget);

    final yearFinder = find.text('yyyy');
    final monthFinder = find.text('mm');
    final dayFinder = find.text('dd');

    expect(yearFinder, findsOneWidget);
    expect(monthFinder, findsOneWidget);
    expect(dayFinder, findsOneWidget);
  });

  testWidgets('''with valid first and last date param, initial date
         null month, day and non-null year ''', (tester) async {
    final widget = MaterialApp(
      home: Scaffold(
        body: DropdownDatePicker(
          firstDate: ValidDate(year: 2005, month: 01, day: 01),
          lastDate: ValidDate(year: 2020, month: 12, day: 12),
          initialDate: NullableValidDate(year: 2010, month: null, day: null),
        ),
      ),
    );

    await tester.pumpWidget(widget);

    expect(find.byType(DropdownDatePicker), findsOneWidget);

    final yearFinder = find.text('2010');
    final monthFinder = find.text('mm');
    final dayFinder = find.text('dd');

    expect(yearFinder, findsOneWidget);
    expect(monthFinder, findsOneWidget);
    expect(dayFinder, findsOneWidget);
  });
}
