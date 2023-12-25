import 'package:flutter/material.dart';
import 'package:one_win/app_colors.dart';
import 'package:one_win/data/models/general_bet.dart';
import 'package:one_win/general_widgets/general_container.dart';
import 'package:one_win/presentation/bet_detail/bet_detail_screen.dart';

class ArchivedBetWidget extends StatelessWidget {
  const ArchivedBetWidget({super.key, required this.generalBet});
  final GeneralBet generalBet;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BetDetailScreen(generalBet: generalBet),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: AppColors.grey),
        child: Row(
          children: [
            Expanded(
              child: GeneralContainer(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Bookie: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      generalBet.bookie,
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
              child: GeneralContainer(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '\$${generalBet.totalBetsProfitLoss.abs()} ${generalBet.totalBetsProfitLoss.isNegative ? 'loss' : 'profit'}',
                    style: TextStyle(
                      color: generalBet.totalBetsProfitLoss.isNegative
                          ? AppColors.red
                          : AppColors.green,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
