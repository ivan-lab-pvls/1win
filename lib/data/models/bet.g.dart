// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bet _$BetFromJson(Map<String, dynamic> json) => Bet(
      homeTeam: json['homeTeam'] as bool,
      name: json['name'] as String,
      amount: json['amount'] as int,
      odd: (json['odd'] as num).toDouble(),
      win: json['win'] as bool,
    );

Map<String, dynamic> _$BetToJson(Bet instance) => <String, dynamic>{
      'homeTeam': instance.homeTeam,
      'name': instance.name,
      'amount': instance.amount,
      'odd': instance.odd,
      'win': instance.win,
    };
