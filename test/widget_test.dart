import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn/main.dart';
import 'package:learn/utils/water_calculator.dart';

void main() {
  group('Water Calculator Unit Tests', () {
    test('Calculates water correctly according to assignment test cases', () {
      expect(
        calculateWaterLitres(weightKg: 50, activityHours: 0.0),
        closeTo(1.75, 0.001),
      );

      expect(
        calculateWaterLitres(weightKg: 60, activityHours: 8.0),
        closeTo(4.10, 0.001),
      );

      expect(
        calculateWaterLitres(weightKg: 70, activityHours: 2.0),
        closeTo(2.95, 0.001),
      );

      expect(
        calculateWaterLitres(weightKg: 90, activityHours: 4.0),
        closeTo(4.15, 0.001),
      );
    });
  });

  group('Water Tracker UI Widget Tests', () {
    testWidgets('InputScreen renders and navigates to ResultScreen and back', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const WaterTrackerApp());
      await tester.pumpAndSettle();

      expect(find.text('Water Tracker'), findsOneWidget);
      expect(find.text('MALE'), findsOneWidget);
      expect(find.text('FEMALE'), findsOneWidget);
      expect(find.text('ACTIVITY (hours/day)'), findsOneWidget);
      expect(find.text('WEIGHT'), findsOneWidget);
      expect(find.text('AGE'), findsOneWidget);
      expect(find.text('Calculate Water Intake'), findsOneWidget);

      await tester.tap(find.text('Calculate Water Intake'));
      await tester.pumpAndSettle();

      expect(find.text('Your Daily Water Intake'), findsOneWidget);
      expect(find.text('2.35 L / Day'), findsOneWidget);
      expect(find.text('Re-calculate'), findsOneWidget);

      await tester.tap(find.text('Re-calculate'));
      await tester.pumpAndSettle();

      expect(find.text('Water Tracker'), findsOneWidget);
      expect(find.text('Calculate Water Intake'), findsOneWidget);
    });

    testWidgets('Counter buttons increment and decrement weight correctly', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const WaterTrackerApp());
      await tester.pumpAndSettle();

      expect(find.text('60'), findsOneWidget);

      final incrementBtn = find.byKey(const Key('increment_weight'));
      await tester.ensureVisible(incrementBtn);
      await tester.tap(incrementBtn);
      await tester.pumpAndSettle();

      expect(find.text('61'), findsOneWidget);

      final decrementBtn = find.byKey(const Key('decrement_weight'));
      await tester.ensureVisible(decrementBtn);
      await tester.tap(decrementBtn);
      await tester.pumpAndSettle();

      expect(find.text('60'), findsOneWidget);
    });
  });
}
