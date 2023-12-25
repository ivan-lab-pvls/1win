import 'package:flutter/material.dart';
import 'package:one_win/app_colors.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({
    super.key,
    this.onTap,
    required this.txt,
  });

  final VoidCallback? onTap;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: onTap == null ? AppColors.textGrey :Theme.of(context).primaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Text(
          txt,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
