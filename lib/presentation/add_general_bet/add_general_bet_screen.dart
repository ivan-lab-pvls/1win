// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:one_win/app_colors.dart';
import 'package:one_win/data/bets_notifier.dart';
import 'package:one_win/data/models/bet.dart';
import 'package:one_win/data/models/general_bet.dart';
import 'package:one_win/general_widgets/add_bet_button.dart';
import 'package:one_win/general_widgets/general_button.dart';
import 'package:one_win/general_widgets/general_text_field.dart';
import 'package:one_win/presentation/add_bet/add_bet_screen.dart';
import 'package:one_win/presentation/bets/widgets/bets_tab_bar.dart';
import 'package:provider/provider.dart';

class AddGeneralBetScreen extends StatefulWidget {
  const AddGeneralBetScreen({super.key});

  @override
  State<AddGeneralBetScreen> createState() => _AddGeneralBetScreenState();
}

class _AddGeneralBetScreenState extends State<AddGeneralBetScreen> {
  final TextEditingController _bookmakerController = TextEditingController();
  final TextEditingController _homeTeamController = TextEditingController();
  final TextEditingController _awayTeamController = TextEditingController();
  final List<Bet> _bets = [];
  var _textFieldsEnabled = true;
  late final BetsNotifier _betsNotifier;

  @override
  void initState() {
    super.initState();
    _betsNotifier = context.read<BetsNotifier>();
    _bookmakerController.addListener(() {
      setState(() {});
    });
    _homeTeamController.addListener(() {
      setState(() {});
    });
    _awayTeamController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _bookmakerController.dispose();
    _homeTeamController.dispose();
    _awayTeamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkGrey,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: UnconstrainedBox(
              child: Image.asset(
                'as/back_button.png',
                height: 42,
              ),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Create new bet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GeneralTextField(
                enabled: _textFieldsEnabled,
                title: 'Bookmaker',
                controller: _bookmakerController,
              ),
              const SizedBox(height: 16),
              GeneralTextField(
                enabled: _textFieldsEnabled,
                title: 'Home Team',
                controller: _homeTeamController,
              ),
              const SizedBox(height: 16),
              GeneralTextField(
                enabled: _textFieldsEnabled,
                title: 'Away Team',
                controller: _awayTeamController,
              ),
              ...List.generate(
                _bets.length,
                (index) => BetItem(
                  bet: _bets[index],
                  homeTeamName: _homeTeamController.text,
                  awayTeamName: _awayTeamController.text,
                ),
              ),
              if (textFieldsFilled && _bets.length < 3) ...[
                _bets.isEmpty
                    ? const SizedBox(height: 16)
                    : const Divider(
                        height: 32,
                        thickness: 3,
                        color: AppColors.darkGrey,
                      ),
                AddBetButton(
                  onTap: () async {
                    final result = await Navigator.of(context).push<Bet?>(
                      MaterialPageRoute(
                        builder: (context) => AddBetScreen(
                          homeTeamName: _homeTeamController.text,
                          awayTeamName: _awayTeamController.text,
                        ),
                      ),
                    );
                    if (result == null) {
                      return;
                    }
                    setState(() {
                      _bets.add(result);
                      _textFieldsEnabled = false;
                    });
                  },
                ),
              ]
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SizedBox(
              height: 50,
              child: GeneralButton(
                onTap: textFieldsFilled && _bets.isNotEmpty
                    ? _createGeneralBet
                    : null,
                txt: 'Save',
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get textFieldsFilled =>
      _bookmakerController.text.isNotEmpty &&
      _homeTeamController.text.isNotEmpty &&
      _awayTeamController.text.isNotEmpty;

  void _createGeneralBet() {
    final generalBet = GeneralBet(
      homeTeamName: _homeTeamController.text,
      awayTeamName: _awayTeamController.text,
      bookie: _bookmakerController.text,
      archived: false,
      bets: _bets,
    );
    _betsNotifier.addBet(generalBet);
    Navigator.of(context).pop();
  }
}

class BetItem extends StatefulWidget {
  const BetItem({
    Key? key,
    required this.bet,
    required this.homeTeamName,
    required this.awayTeamName,
  }) : super(key: key);

  final Bet bet;
  final String homeTeamName;
  final String awayTeamName;

  @override
  State<BetItem> createState() => _BetItemState();
}

class _BetItemState extends State<BetItem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _oddController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _oddController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          height: 32,
          thickness: 3,
          color: AppColors.darkGrey,
        ),
        IgnorePointer(
          child: BetsTabBar(
            index: widget.bet.homeTeam ? 0 : 1,
            onTap: (index) {},
            text0: widget.homeTeamName,
            text1: widget.awayTeamName,
          ),
        ),
        const SizedBox(height: 16),
        GeneralTextField(
          enabled: false,
          title: 'Bet name',
          controller: _nameController..text = widget.bet.name,
        ),
        const SizedBox(height: 16),
        GeneralTextField(
          enabled: false,
          title: 'Bet amount',
          controller: _amountController..text = widget.bet.amount.toString(),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          suffixIcon: const Text(
            '\$',
            style: TextStyle(
              color: AppColors.textGrey,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 16),
        GeneralTextField(
          enabled: false,
          title: 'Odd',
          controller: _oddController..text = widget.bet.odd.toStringAsFixed(2),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'[0-9.]'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Profit:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            Switch(
              activeColor: AppColors.primary,
              inactiveTrackColor: Colors.white.withOpacity(0.5),
              value: widget.bet.win,
              onChanged: (value) {},
            ),
          ],
        ),
      ],
    );
  }
}
