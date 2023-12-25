import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_win/presentation/bets/bets.dart';
import 'package:one_win/general_widgets/general_button.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Image.asset(
                'as/football.png',
                fit: BoxFit.fitWidth,
              ),
              Spacer(flex: 2),
              const Text(
                'Start winning!',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              const OnBoardingRow(
                svg: 'as/step1.svg',
                text1: 'Step 1. Analyze',
                text2:
                    'Add all your bets into one place, so you can easy understand what your weakness.',
              ),
              const SizedBox(height: 16),
              const OnBoardingRow(
                svg: 'as/step2.svg',
                text1: 'Step 2. Predict',
                text2:
                    'See throw all possible statistic of the team that you can find. And especially new players.',
              ),
              const SizedBox(height: 16),
              const OnBoardingRow(
                svg: 'as/step2.svg',
                text1: 'Step 3. Multiply',
                text2:
                    'As far as you find a good way to win, don’t be afraid to multiply your bets!',
              ),
              Spacer(flex: 2),
              GeneralButton(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BetsScreen(),
                  ),
                ),
                txt: 'Start',
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class OnBoardingRow extends StatelessWidget {
  const OnBoardingRow({
    super.key,
    required this.svg,
    required this.text1,
    required this.text2,
  });

  final String svg;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          svg,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text2,
                style: TextStyle(
                  color: Color(0xFF99a2b4),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
