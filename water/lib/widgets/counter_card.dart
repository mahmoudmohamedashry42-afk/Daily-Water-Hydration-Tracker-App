import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CounterCard extends StatelessWidget {
  final String title;
  final int value;
  final String unit;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: kActiveCardColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: kLabelTextStyle, textAlign: TextAlign.center),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('$value', style: kNumberTextStyle),
                const SizedBox(width: 4.0),
                Text(unit, style: kUnitTextStyle),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _RoundIconButton(
                  key: Key('decrement_${title.toLowerCase()}'),
                  icon: Icons.remove,
                  onPressed: onDecrement,
                  tooltip: 'Decrease $title',
                ),
                const SizedBox(width: 14.0),
                _RoundIconButton(
                  key: Key('increment_${title.toLowerCase()}'),
                  icon: Icons.add,
                  onPressed: onIncrement,
                  tooltip: 'Increase $title',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  const _RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: const Color(0xFF25294A),
        shape: const CircleBorder(),
        elevation: 3.0,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          splashColor: kPrimaryWaterColor.withValues(alpha: 0.3),
          child: SizedBox(
            width: 48.0,
            height: 48.0,
            child: Icon(icon, color: kPrimaryTextColor, size: 22.0),
          ),
        ),
      ),
    );
  }
}
