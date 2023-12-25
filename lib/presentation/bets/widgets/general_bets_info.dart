import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_win/app_colors.dart';
import 'package:one_win/data/bets_notifier.dart';
import 'package:one_win/general_widgets/add_bet_button.dart';
import 'package:provider/provider.dart';

class GeneralBetsInfo extends StatelessWidget {
  const GeneralBetsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final BetsNotifier betsNotifier = context.read<BetsNotifier>();

    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            AppColors.purple,
            AppColors.primary,
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(14.5),
        ),
        child: Column(
          children: [
            ProfitLossRow(
              isProfit: true,
              dollars: betsNotifier.totalProfit.toStringAsFixed(2),
              percent: betsNotifier.profitPercent.toString(),
            ),
            const SizedBox(height: 16),
            ProfitLossRow(
              isProfit: false,
              dollars: betsNotifier.totalLoss.toStringAsFixed(2),
              percent: betsNotifier.lossPercent.toString(),
            ),
            const SizedBox(height: 16),
            GeneralBetsInfoRow(
              wins: betsNotifier.winBets,
              lost: betsNotifier.lostBets,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfitLossRow extends StatelessWidget {
  const ProfitLossRow({
    super.key,
    required this.isProfit,
    required this.dollars,
    required this.percent,
  });

  final bool isProfit;
  final String dollars;
  final String percent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.darkGrey,
                ),
                child: SvgPicture.asset(
                  isProfit ? 'as/arrow_up.svg' : 'as/arrow_down.svg',
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isProfit ? 'Profit:' : 'Loss:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: UnconstrainedBox(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.darkGrey,
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                '\$$dollars',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: UnconstrainedBox(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.darkGrey,
                ),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  '$percent%',
                  style: TextStyle(
                    color: isProfit ? AppColors.green : AppColors.red,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GeneralBetsInfoRow extends StatelessWidget {
  const GeneralBetsInfoRow({
    super.key,
    required this.wins,
    required this.lost,
  });

  final int wins;
  final int lost;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.darkGrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'All bets: ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  (wins + lost).toString(),
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.darkGrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Win: ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  wins.toString(),
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.darkGrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Lost: ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  lost.toString(),
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
