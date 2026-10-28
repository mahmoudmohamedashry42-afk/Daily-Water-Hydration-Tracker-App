import 'package:flutter/material.dart';

import 'screens/input_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const WaterTrackerApp());
}

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackgroundColor,
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: kPrimaryWaterColor,
          secondary: kPrimaryWaterColor,
          surface: kActiveCardColor,
        ),
      ),
      home: const InputScreen(),
    );
  }
}

typedef MyApp = WaterTrackerApp;
