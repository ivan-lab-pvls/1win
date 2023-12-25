import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_win/app_colors.dart';

class AddBetButton extends StatelessWidget {
  const AddBetButton({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: const LinearGradient(
            colors: [
              AppColors.purple,
              AppColors.primary,
            ],
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'as/circle_plus.svg',
              width: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'New bet',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
