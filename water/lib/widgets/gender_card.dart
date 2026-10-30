import 'package:flutter/material.dart';

import '../utils/constants.dart';

enum Gender { male, female }

class GenderCard extends StatelessWidget {
  final Gender gender;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMale = gender == Gender.male;
    final IconData icon = isMale ? Icons.male : Icons.female;
    final String label = isMale ? 'MALE' : 'FEMALE';

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Semantics(
          label: '$label gender selection',
          selected: isSelected,
          button: true,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected ? kActiveCardColor : kInactiveCardColor,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: isSelected ? kPrimaryWaterColor : Colors.transparent,
                width: 2.0,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: kPrimaryWaterColor.withValues(alpha: 0.2),
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
                      ),
                    ]
                  : [],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16.0),
                splashColor: kPrimaryWaterColor.withValues(alpha: 0.2),
                highlightColor: kPrimaryWaterColor.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 65.0,
                        color: isSelected
                            ? kPrimaryWaterColor
                            : kSecondaryTextColor,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        label,
                        style: isSelected
                            ? kLabelTextStyle.copyWith(
                                color: kPrimaryTextColor,
                                fontWeight: FontWeight.bold,
                              )
                            : kLabelTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
