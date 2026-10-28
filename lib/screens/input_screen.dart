import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/water_calculator.dart';
import '../widgets/bottom_button.dart';
import '../widgets/counter_card.dart';
import '../widgets/gender_card.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  Gender? selectedGender = Gender.male;
  double activityHours = 1.0;
  int weight = 60;
  int age = 20;

  static const int minWeight = 30;
  static const int maxWeight = 200;
  static const int minAge = 10;
  static const int maxAge = 100;
  static const double minActivity = 0.0;
  static const double maxActivity = 8.0;

  void _incrementWeight() {
    if (weight < maxWeight) {
      setState(() {
        weight++;
      });
    }
  }

  void _decrementWeight() {
    if (weight > minWeight) {
      setState(() {
        weight--;
      });
    }
  }

  void _incrementAge() {
    if (age < maxAge) {
      setState(() {
        age++;
      });
    }
  }

  void _decrementAge() {
    if (age > minAge) {
      setState(() {
        age--;
      });
    }
  }

  void _resetToDefaults() {
    setState(() {
      selectedGender = Gender.male;
      activityHours = 1.0;
      weight = 60;
      age = 20;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reset all inputs to default values'),
        duration: Duration(seconds: 1),
        backgroundColor: kActiveCardColor,
      ),
    );
  }

  void _calculateAndNavigate() {
    if (selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a gender / يرجى تحديد الجنس أولاً'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final double litres = calculateWaterLitres(
      weightKg: weight,
      activityHours: activityHours,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          litres: litres,
          weight: weight,
          age: age,
          activityHours: activityHours,
          gender: selectedGender,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.water_drop, color: kPrimaryWaterColor, size: 26.0),
            SizedBox(width: 8.0),
            Text(
              'Water Tracker',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: kPrimaryTextColor,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt, color: kSecondaryTextColor),
            tooltip: 'Reset to defaults',
            onPressed: _resetToDefaults,
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              GenderCard(
                                gender: Gender.male,
                                isSelected: selectedGender == Gender.male,
                                onTap: () {
                                  setState(() {
                                    selectedGender = Gender.male;
                                  });
                                },
                              ),
                              GenderCard(
                                gender: Gender.female,
                                isSelected: selectedGender == Gender.female,
                                onTap: () {
                                  setState(() {
                                    selectedGender = Gender.female;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 6.0,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: kActiveCardColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'ACTIVITY (hours/day)',
                                style: kLabelTextStyle,
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    activityHours.toStringAsFixed(1),
                                    style: kNumberTextStyle,
                                  ),
                                  const SizedBox(width: 4.0),
                                  const Text('h', style: kUnitTextStyle),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Slider(
                                value: activityHours,
                                min: minActivity,
                                max: maxActivity,

                                activeColor: kPrimaryWaterColor,
                                inactiveColor: const Color(0xFF25294A),
                                onChanged: (double newValue) {
                                  setState(() {
                                    activityHours = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              CounterCard(
                                title: 'WEIGHT',
                                value: weight,
                                unit: 'kg',
                                onIncrement: _incrementWeight,
                                onDecrement: _decrementWeight,
                              ),
                              CounterCard(
                                title: 'AGE',
                                value: age,
                                unit: 'yrs',
                                onIncrement: _incrementAge,
                                onDecrement: _decrementAge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      BottomButton(
                        title: 'Calculate Water Intake',
                        icon: Icons.water_drop,
                        onTap: _calculateAndNavigate,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
