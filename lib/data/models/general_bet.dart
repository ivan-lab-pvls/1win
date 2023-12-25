// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:one_win/data/models/bet.dart';

part 'general_bet.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GeneralBet {
  const GeneralBet({
    required this.homeTeamName,
    required this.awayTeamName,
    required this.bookie,
    required this.archived,
    required this.bets,
  });

  factory GeneralBet.fromJson(Map<String, dynamic> json) =>
      _$GeneralBetFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralBetToJson(this);

  final String homeTeamName;
  final String awayTeamName;
  final String bookie;
  final bool archived;
  final List<Bet> bets;

  GeneralBet copyWith({
    String? homeTeamName,
    String? awayTeamName,
    String? bookie,
    bool? archived,
    List<Bet>? bets,
  }) {
    return GeneralBet(
      homeTeamName: homeTeamName ?? this.homeTeamName,
      awayTeamName: awayTeamName ?? this.awayTeamName,
      bookie: bookie ?? this.bookie,
      archived: archived ?? this.archived,
      bets: bets ?? this.bets,
    );
  }

  double get totalBetsAmount {
    double totalBetsAmount = 0.0;

    for (var bet in bets) {
      totalBetsAmount += bet.amount;
    }

    return totalBetsAmount;
  }

  double get totalBetsProfitLoss {
    double totalBetsProfitLoss = 0.0;

    for (var bet in bets) {
      if (bet.win) {
        totalBetsProfitLoss += bet.amount * bet.odd;
      } else {
        totalBetsProfitLoss -= bet.amount;
      }
    }

    return totalBetsProfitLoss;
  }

  bool get singleBet => bets.length == 1;
}
