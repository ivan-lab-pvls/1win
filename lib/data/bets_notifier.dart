import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one_win/data/models/bet.dart';
import 'package:one_win/data/models/general_bet.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _betsKey = '_betsKey';

class BetsNotifier extends ChangeNotifier {
  BetsNotifier(this._preferences);
  final SharedPreferences _preferences;

  List<GeneralBet> bets = [];

  void init() {
    final cached = _preferences.getString(_betsKey) ?? '';

    if (cached.isEmpty) {
      return;
    }

    final dyn = jsonDecode(cached) as List<dynamic>;
    final cachedBets = dyn.map((e) => GeneralBet.fromJson(e)).toList();
    bets = cachedBets;
    notifyListeners();
  }

  List<GeneralBet> get activeBets =>
      bets.where((element) => !element.archived).toList();

  List<GeneralBet> get archivedBets =>
      bets.where((element) => element.archived).toList();

  void addBet(GeneralBet bet) {
    bets.add(bet);
    _cacheBets();
    notifyListeners();
  }

  void deleteBet(GeneralBet bet) {
    bets.remove(bet);
    _cacheBets();
    notifyListeners();
  }

  void _cacheBets() async {
    final jsons = bets.map((e) => e.toJson()).toList();
    final encoded = jsonEncode(jsons);
    await _preferences.setString(_betsKey, encoded);
  }

  void setArchivedTrue(GeneralBet generalBet) {
    final index = bets.indexOf(generalBet);
    final newGeneralBet = generalBet.copyWith(archived: true);
    bets.removeAt(index);
    bets.insert(index, newGeneralBet);
    _cacheBets();
    notifyListeners();
  }

  double get totalProfit {
    final List<Bet> profitBets = [];

    for (var generalBet in bets) {
      for (var bet in generalBet.bets) {
        if (bet.win) {
          profitBets.add(bet);
        }
      }
    }

    double totalProfit = 0;

    for (var bet in profitBets) {
      var winAmount = bet.amount * bet.odd;
      totalProfit += winAmount;
    }

    return totalProfit;
  }

  double get totalLoss {
    final List<Bet> lossBets = [];

    for (var generalBet in bets) {
      for (var bet in generalBet.bets) {
        if (!bet.win) {
          lossBets.add(bet);
        }
      }
    }
    double totalLoss = 0;

    for (var bet in lossBets) {
      totalLoss += bet.amount;
    }

    return totalLoss;
  }

  double get _totalBetAmount {
    final List<Bet> allBets = [];

    for (var generalBet in bets) {
      for (var bet in generalBet.bets) {
        allBets.add(bet);
      }
    }

    double totalBetAmount = 0;

    for (var bet in allBets) {
      if (bet.win) {
        totalBetAmount += bet.amount * bet.odd;
      } else {
        totalBetAmount += bet.amount;
      }
    }

    return totalBetAmount;
  }

  int get profitPercent {
    if (_totalBetAmount == 0) {
      return 0;
    }
    final percent = ((totalProfit / _totalBetAmount) * 100).round();
    return percent;
  }

  int get lossPercent {
    if (_totalBetAmount == 0) {
      return 0;
    }
    final percent = ((totalLoss / _totalBetAmount) * 100).round();
    return percent;
  }

  int get winBets {
    var winBets = 0;

    for (var generalBet in bets) {
      for (var bet in generalBet.bets) {
        if (bet.win) {
          winBets++;
        }
      }
    }
    return winBets;
  }

  int get lostBets {
    var lostBets = 0;

    for (var generalBet in bets) {
      for (var bet in generalBet.bets) {
        if (!bet.win) {
          lostBets++;
        }
      }
    }
    return lostBets;
  }
}
