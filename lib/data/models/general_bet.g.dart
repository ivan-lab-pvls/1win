// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_bet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralBet _$GeneralBetFromJson(Map<String, dynamic> json) => GeneralBet(
      homeTeamName: json['home_team_name'] as String,
      awayTeamName: json['away_team_name'] as String,
      bookie: json['bookie'] as String,
      archived: json['archived'] as bool,
      bets: (json['bets'] as List<dynamic>)
          .map((e) => Bet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeneralBetToJson(GeneralBet instance) =>
    <String, dynamic>{
      'home_team_name': instance.homeTeamName,
      'away_team_name': instance.awayTeamName,
      'bookie': instance.bookie,
      'archived': instance.archived,
      'bets': instance.bets,
    };
