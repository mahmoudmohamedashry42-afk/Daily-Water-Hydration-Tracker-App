import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/water_calculator.dart';
import '../widgets/bottom_button.dart';
import '../widgets/gender_card.dart';

class ResultScreen extends StatelessWidget {
  final double litres;
  final int weight;
  final int age;
  final double activityHours;
  final Gender? gender;

  const ResultScreen({
    super.key,
    required this.litres,
    required this.weight,
    required this.age,
    required this.activityHours,
    this.gender,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedLitres = litres.toStringAsFixed(2);
    final String guidanceText = getGuidanceText(litres);
    final String genderLabel = gender == Gender.female ? 'Female' : 'Male';

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Your Daily Water Intake',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: kPrimaryTextColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: kPrimaryTextColor),
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 28.0,
                        horizontal: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: kActiveCardColor,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: kPrimaryWaterColor.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryWaterColor.withValues(alpha: 0.12),
                            blurRadius: 16.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryWaterColor.withValues(alpha: 0.12),
                            ),
                            child: const Icon(
                              Icons.water_drop,
                              size: 48.0,
                              color: kPrimaryWaterColor,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            '$formattedLitres L / Day',
                            style: kResultNumberStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6.0),
                          const Text(
                            'Estimated value (educational formula)',
                            style: kSubtitleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12.0),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: LinearProgressIndicator(
                              value: (litres / 5.0).clamp(0.0, 1.0),
                              minHeight: 8.0,
                              backgroundColor: const Color(0xFF111328),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                kPrimaryWaterColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: kInactiveCardColor,
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: kSecondaryTextColor,
                            size: 20.0,
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              'Educational estimate only — not medical advice.\nهذا التقدير مبني على معادلة تعليمية وليس توصية طبية بديلة.',
                              style: TextStyle(
                                color: kSecondaryTextColor,
                                fontSize: 13.0,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: kActiveCardColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.tips_and_updates_outlined,
                                color: kPrimaryWaterColor,
                                size: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Hydration Guidance / نصيحة الترطيب',
                                style: TextStyle(
                                  color: kPrimaryTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            guidanceText,
                            style: const TextStyle(
                              color: kSecondaryTextColor,
                              fontSize: 14.0,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: kActiveCardColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Input Summary / ملخص المدخلات',
                            style: TextStyle(
                              color: kPrimaryTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: _SummaryItem(
                                  label: 'Gender',
                                  value: genderLabel,
                                  icon: gender == Gender.female
                                      ? Icons.female
                                      : Icons.male,
                                ),
                              ),
                              Expanded(
                                child: _SummaryItem(
                                  label: 'Weight',
                                  value: '$weight kg',
                                  icon: Icons.fitness_center,
                                ),
                              ),
                              Expanded(
                                child: _SummaryItem(
                                  label: 'Age',
                                  value: '$age yrs',
                                  icon: Icons.cake_outlined,
                                ),
                              ),
                              Expanded(
                                child: _SummaryItem(
                                  label: 'Activity',
                                  value:
                                      '${activityHours.toStringAsFixed(1)} h',
                                  icon: Icons.directions_run,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomButton(
              title: 'Re-calculate',
              icon: Icons.refresh,
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20.0, color: kPrimaryWaterColor),
        const SizedBox(height: 6.0),
        Text(
          value,
          style: const TextStyle(
            color: kPrimaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2.0),
        Text(
          label,
          style: const TextStyle(color: kSecondaryTextColor, fontSize: 12.0),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
