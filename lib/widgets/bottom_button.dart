import 'package:flutter/material.dart';

import '../utils/constants.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;

  const BottomButton({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: kBottomButtonColor,
          foregroundColor: const Color(0xFF0A0E21),
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 24.0, color: const Color(0xFF0A0E21)),
              const SizedBox(width: 8.0),
            ],
            Text(title, style: kLargeButtonTextStyle),
          ],
        ),
      ),
    );
  }
}
