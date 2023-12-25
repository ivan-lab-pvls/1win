import 'package:flutter/material.dart';
import 'package:one_win/app_colors.dart';

class BetsTabBar extends StatelessWidget {
  const BetsTabBar({
    super.key,
    required this.index,
    required this.onTap, required this.text0, required this.text1,
  });

  final int index;
  final void Function(int) onTap;
  final String text0;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth * 0.5;
            return AnimatedAlign(
              curve: Curves.ease,
              alignment:
                  index == 0 ? Alignment.centerLeft : Alignment.centerRight,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: width,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.purple,
                      AppColors.primary,
                    ],
                  ),
                ),
              ),
            );
          }),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => onTap(0),
                  child: Center(
                    child: Text(
                      text0,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => onTap(1),
                  child: Center(
                    child: Text(
                      text1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
