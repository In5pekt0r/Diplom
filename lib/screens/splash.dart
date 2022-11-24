import 'package:webrtc_conference/common/route.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Splash',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/ADSD_Logo_small.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
