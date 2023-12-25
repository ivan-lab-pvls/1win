import 'package:flutter/material.dart';
import 'package:one_win/app_colors.dart';
import 'package:one_win/data/bets_notifier.dart';
import 'package:one_win/data/models/bet.dart';
import 'package:one_win/data/models/general_bet.dart';
import 'package:one_win/general_widgets/general_button.dart';
import 'package:one_win/general_widgets/general_container.dart';
import 'package:one_win/presentation/bet_detail/widgets/general_bet_detail_widget.dart';
import 'package:provider/provider.dart';

class BetDetailScreen extends StatelessWidget {
  const BetDetailScreen({
    super.key,
    required this.generalBet,
  });

  final GeneralBet generalBet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.darkGrey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.grey,
                ),
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
              ),
            ),
            const Text(
              'Bet detail',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                final betsNotifier = context.read<BetsNotifier>();
                betsNotifier.deleteBet(generalBet);
                Navigator.of(context).pop();
              },
              child: Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.grey,
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GeneralBetDetailWidget(generalBet: generalBet),
            const SizedBox(height: 16),
            ...List.generate(
              generalBet.bets.length,
              (index) => BetDetailWidget(
                teamName: generalBet.bets[index].homeTeam
                    ? generalBet.homeTeamName
                    : generalBet.awayTeamName,
                bet: generalBet.bets[index],
              ),
            ),
            const SizedBox(height: 8),
            GeneralButton(
              txt: 'Set results',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BetDetailWidget extends StatelessWidget {
  const BetDetailWidget({super.key, required this.teamName, required this.bet});
  final String teamName;
  final Bet bet;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.grey,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Text(
                  bet.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  teamName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    color: bet.homeTeam ? AppColors.primary : AppColors.purple,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: GeneralContainer(
                      child: FittedBox(
                        child: Row(
                          children: [
                            const Text(
                              'Amount: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            FittedBox(
                              child: Text(
                                '\$${bet.amount}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GeneralContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Odd: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            bet.odd.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GeneralContainer(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '\$${bet.win ? (bet.amount * bet.odd).round() : bet.amount.toString()} ${bet.win ? 'profit' : 'loss'}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: bet.win ? AppColors.green : AppColors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
