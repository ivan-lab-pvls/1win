import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_win/app_colors.dart';
import 'package:one_win/data/models/bet.dart';
import 'package:one_win/general_widgets/general_button.dart';
import 'package:one_win/general_widgets/general_text_field.dart';
import 'package:one_win/presentation/bets/widgets/bets_tab_bar.dart';

class AddBetScreen extends StatefulWidget {
  const AddBetScreen(
      {super.key, required this.homeTeamName, required this.awayTeamName});
  final String homeTeamName;
  final String awayTeamName;

  @override
  State<AddBetScreen> createState() => _AddBetScreenState();
}

class _AddBetScreenState extends State<AddBetScreen> {
  var _teamIndex = 0;
  var _switch = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _oddController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {});
    });
    _amountController.addListener(() {
      setState(() {});
    });
    _oddController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _oddController.dispose();
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
              BetsTabBar(
                index: _teamIndex,
                onTap: (index) => setState(() {
                  _teamIndex = index;
                }),
                text0: widget.homeTeamName,
                text1: widget.awayTeamName,
              ),
              const SizedBox(height: 16),
              GeneralTextField(
                title: 'Bet name',
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              GeneralTextField(
                title: 'Bet amount',
                controller: _amountController,
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
                title: 'Odd',
                controller: _oddController,
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
                  Text(
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
                    value: _switch,
                    onChanged: (value) => setState(() {
                      _switch = value;
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SizedBox(
              height: 50,
              child: GeneralButton(
                onTap: _nameController.text.isNotEmpty &&
                        _amountController.text.isNotEmpty &&
                        _oddController.text.isNotEmpty
                    ? _createBet
                    : null,
                txt: 'Save',
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _createBet() {
    final bet = Bet(
      homeTeam: _teamIndex == 0,
      name: _nameController.text,
      amount: int.tryParse(_amountController.text) ?? 0,
      odd: double.parse(
          (double.tryParse(_oddController.text) ?? 0.0).toStringAsFixed(2)),
      win: _switch,
    );

    Navigator.of(context).pop(bet);
  }
}
