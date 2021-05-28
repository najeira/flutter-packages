import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('with valid initial, first and last date params', (tester) async {
    final dpdWidget = DropdownDatePicker(
      firstYear: 2005,
      lastYear: 2020,
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

    expect(find.text('2005'), findsOneWidget);
    expect(find.text('2007'), findsOneWidget);
    expect(find.text('2020'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
    expect(find.text('31'), findsNothing);
  });

  testWidgets('with valid first and last date param but null initial date',
      (tester) async {
    const widget = MaterialApp(
      home: Scaffold(
        body: DropdownDatePicker(
          firstYear: 2005,
          lastYear: 2020,
        ),
      ),
    );

    await tester.pumpWidget(widget);

    expect(find.byType(DropdownDatePicker), findsOneWidget);

    expect(find.text('2005'), findsOneWidget);
    expect(find.text('2007'), findsOneWidget);
    expect(find.text('2020'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
    expect(find.text('31'), findsOneWidget);
  });

  testWidgets('''with valid first and last date param, initial date
         null month, day and non-null year ''', (tester) async {
    final widget = MaterialApp(
      home: Scaffold(
        body: DropdownDatePicker(
          firstYear: 2005,
          lastYear: 2020,
          initialDate: NullableValidDate(year: 2010, month: null, day: null),
        ),
      ),
    );

    await tester.pumpWidget(widget);

    expect(find.byType(DropdownDatePicker), findsOneWidget);

    expect(find.text('2005'), findsOneWidget);
    expect(find.text('2007'), findsOneWidget);
    expect(find.text('2020'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
    expect(find.text('31'), findsOneWidget);
  });
}
