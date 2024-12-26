import 'package:flutter/material.dart';
import 'package:pos_mobile/feature/ui/color.dart';
import 'package:pos_mobile/feature/ui/dimension.dart';
import 'package:pos_mobile/feature/ui/typography.dart';

class CartButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final VoidCallback onPressed;

  const CartButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // color: secondaryColor,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius200),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: mSemiBold.copyWith(color: textNeutralPrimary)
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: iconColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
