import 'package:flutter/material.dart';
import 'package:one_win/app_colors.dart';
import 'package:one_win/data/models/general_bet.dart';
import 'package:one_win/general_widgets/general_button.dart';
import 'package:one_win/general_widgets/general_container.dart';
import 'package:one_win/presentation/bet_detail/bet_detail_screen.dart';

class GeneralBetWidget extends StatelessWidget {
  const GeneralBetWidget({
    super.key,
    required this.generalBet,
    required this.onFinishTap,
  });

  final GeneralBet generalBet;
  final VoidCallback onFinishTap;
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
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                color: AppColors.darkGrey,
                thickness: 3,
                height: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 16,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 16,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.purple,
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            generalBet.homeTeamName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            generalBet.awayTeamName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            generalBet.singleBet ? 'Bet' : 'Bets',
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 14,
                            ),
                          ),
                          GeneralContainer(
                            child: Text(
                              '\$${generalBet.totalBetsAmount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    generalBet.singleBet
                        ? Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Odds',
                                  style: TextStyle(
                                    color: AppColors.textGrey,
                                    fontSize: 14,
                                  ),
                                ),
                                GeneralContainer(
                                  child: Text(
                                    generalBet.bets.first.odd.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Expanded(
                            flex: 3,
                            child: Text(
                              'Multi\nbets',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                    Expanded(
                      flex: 4,
                      child: GeneralButton(
                        onTap: onFinishTap,
                        txt: 'FINISH > ',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
