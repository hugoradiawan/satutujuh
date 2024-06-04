import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:satutujuh/features/sequence/presentation/sequence_calculator.page.dart';

void main() {
  group('Test invalid Input and calculation selection:', () {
    testWidgets('Input non Number', (widgetTester) async {
      await widgetTester
          .pumpWidget(const MaterialApp(home: SequenceCalculatorPage()));
      final Finder textField = find.byKey(const Key('input_text_field'));
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'abc');
      await widgetTester.pumpAndSettle();
      expect(find.text('abc'), findsOneWidget);
      expect(find.text('Invalid input'), findsOneWidget);
    });

    testWidgets('Input Number with no selected calculation',
        (widgetTester) async {
      await widgetTester
          .pumpWidget(const MaterialApp(home: SequenceCalculatorPage()));
      final Finder textField = find.byKey(const Key('input_text_field'));
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, '123');
      await widgetTester.pumpAndSettle();
      expect(find.text('123'), findsOneWidget);
      expect(find.text('No calculation selected'), findsOneWidget);
    });
  });

  testWidgets('selected 1 changes color', (widgetTester) async {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    await widgetTester.pumpWidget(MaterialApp(
      home: const SequenceCalculatorPage(),
      navigatorKey: navigatorKey,
    ));
    final Finder select1 = find.byWidgetPredicate(
      (Widget widget) =>
          widget is ElevatedButton &&
          widget.key == const Key('calculation_type_1'),
    );
    expect(select1, findsOneWidget);
    await widgetTester.tap(select1);
    await widgetTester.pumpAndSettle();

    expect(
        (widgetTester.widget(select1) as ElevatedButton)
            .style
            ?.backgroundColor!
            .resolve({MaterialState.pressed}),
        ElevatedButton.styleFrom(
          backgroundColor:
              Theme.of(navigatorKey.currentContext!).colorScheme.primary,
        ).backgroundColor?.resolve({MaterialState.pressed}));

    final Finder select2 = find.byWidgetPredicate(
      (Widget widget) =>
          widget is ElevatedButton &&
          widget.key == const Key('calculation_type_2'),
    );

    final Finder select3 = find.byWidgetPredicate(
      (Widget widget) =>
          widget is ElevatedButton &&
          widget.key == const Key('calculation_type_3'),
    );

    final Finder select4 = find.byWidgetPredicate(
      (Widget widget) =>
          widget is ElevatedButton &&
          widget.key == const Key('calculation_type_4'),
    );

    expect(
        widgetTester
            .widget<ElevatedButton>(select2)
            .style
            ?.backgroundColor!
            .resolve({}),
        ElevatedButton.styleFrom(
          backgroundColor:
              Theme.of(navigatorKey.currentContext!).colorScheme.secondary,
        ).backgroundColor?.resolve({}));

    expect(
        widgetTester
            .widget<ElevatedButton>(select3)
            .style
            ?.backgroundColor!
            .resolve({}),
        ElevatedButton.styleFrom(
          backgroundColor:
              Theme.of(navigatorKey.currentContext!).colorScheme.secondary,
        ).backgroundColor?.resolve({}));

    expect(
        widgetTester
            .widget<ElevatedButton>(select4)
            .style
            ?.backgroundColor!
            .resolve({}),
        ElevatedButton.styleFrom(
          backgroundColor:
              Theme.of(navigatorKey.currentContext!).colorScheme.secondary,
        ).backgroundColor?.resolve({}));
  });
}
