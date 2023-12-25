
import 'package:json_annotation/json_annotation.dart';

part 'bet.g.dart';

@JsonSerializable()
class Bet {
  const Bet({
    required this.homeTeam,
    required this.name,
    required this.amount,
    required this.odd,
    required this.win,
  });

  factory Bet.fromJson(Map<String, dynamic> json) => _$BetFromJson(json);

  Map<String, dynamic> toJson() => _$BetToJson(this);

  final bool homeTeam;
  final String name;
  final int amount;
  final double odd;
  final bool win;
}
