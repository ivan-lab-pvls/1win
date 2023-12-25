import 'package:flutter/material.dart';
import 'package:one_win/app_colors.dart';

class GeneralContainer extends StatelessWidget {
  const GeneralContainer({
    super.key,
    this.color = AppColors.darkGrey,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    required this.child,
    this.alignment = Alignment.centerLeft,
  });

  final Color color;
  final EdgeInsets padding;
  final Widget child;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: child,
    );
  }
}
