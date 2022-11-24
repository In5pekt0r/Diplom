import 'package:flutter/material.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:webrtc_conference/screens/splash.dart';

import '../../main.dart';

class StartScreen extends StatefulWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Start',
      builder: (_) => this,
      fullscreenDialog: true,
    );
  }

  @override
  _StartScreenState createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(_onAfterBuild);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void _onAfterBuild(Duration timeStamp) async {
    await _initStartMap();
  }

  Future<void> _initStartMap() async {
    if (appState?['StartMap.isInitialized'] as bool? ?? false) {
      return;
    }
    // TODO: WelcomeScreen
    final value = await navigator?.push<bool>(
      SplashScreen().getRoute(),
    );
    if (value ?? false) {
      appState?['StartMap.isInitialized'] = true;
    }
  }
}
