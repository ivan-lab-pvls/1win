import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_win/app_colors.dart';

class GeneralTextField extends StatelessWidget {
  const GeneralTextField({
    super.key,
    required this.title,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    this.enabled = true,
  });

  final String title;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textGrey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.darkGrey,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  enabled: enabled,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  inputFormatters: inputFormatters,
                  keyboardType: keyboardType,
                  controller: controller,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 14,
                    ),
                    hintText: title,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              if (suffixIcon != null) ...[
                const SizedBox(width: 8),
                suffixIcon!,
              ]
            ],
          ),
        ),
      ],
    );
  }
}
