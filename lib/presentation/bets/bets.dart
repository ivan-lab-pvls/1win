import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:one_win/data/bets_notifier.dart';
import 'package:one_win/general_widgets/add_bet_button.dart';
import 'package:one_win/presentation/add_general_bet/add_general_bet_screen.dart';
import 'package:one_win/presentation/bets/widgets/archived_bet_widget.dart';
import 'package:one_win/presentation/bets/widgets/bets_tab_bar.dart';
import 'package:one_win/presentation/bets/widgets/general_bet_widget.dart';
import 'package:one_win/presentation/bets/widgets/general_bets_info.dart';
import 'package:one_win/presentation/bets/widgets/settings_dialog.dart';
import 'package:provider/provider.dart';

class BetsScreen extends StatefulWidget {
  const BetsScreen({super.key});

  @override
  State<BetsScreen> createState() => _BetsScreenState();
}

class _BetsScreenState extends State<BetsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  late final BetsNotifier _betsNotifier;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _betsNotifier = context.read<BetsNotifier>()..addListener(_update);
  }

  void _update() {
    setState(() {});
  }

  @override
  void dispose() {
    _betsNotifier.removeListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('as/one_win_logo.svg'),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const SettingsDialog(),
                );
              },
              child: Image.asset(
                'as/settings_button.png',
                height: 45,
                width: 45,
              ),
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(child: GeneralBetsInfo()),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              sliver: SliverToBoxAdapter(
                child: BetsTabBar(
                  text0: 'Active bets',
                  text1: 'Archive',
                  index: _controller.index,
                  onTap: (index) {
                    setState(() {
                      _controller.index = index;
                    });
                  },
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: [
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _betsNotifier.activeBets.length,
              itemBuilder: (context, index) {
                final generalBet = _betsNotifier.activeBets[index];

                return GeneralBetWidget(
                  generalBet: generalBet,
                  onFinishTap: () {
                    _betsNotifier.setArchivedTrue(generalBet);
                  },
                );
              },
            ),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _betsNotifier.archivedBets.length,
              itemBuilder: (context, index) {
                final generalBet = _betsNotifier.archivedBets[index];

                return ArchivedBetWidget(
                  generalBet: generalBet,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: AddBetButton(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddGeneralBetScreen(),
          ),
        ),
      ),
    );
  }
}
