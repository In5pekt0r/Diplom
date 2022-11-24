import 'package:webrtc_conference/common/route.dart';
import 'package:flutter/material.dart';
import 'package:webrtc_conference/screens/auth/login.dart';
import 'package:webrtc_conference/widgets/blue_rounded_button.dart';

import '../../main.dart';
import '../../widgets/hero_adsd_logo.dart';

class WelcomeScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Welcome',
      builder: (_) => this,
    );
  }

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Login_Background@2x.png'),
            fit: BoxFit.fitWidth,
          )
        ),
        child: Transform.translate(
          offset: const Offset(0, -65),
          child: const EnterForm(),
        ),
      )
    );
  }
}

class EnterForm extends StatelessWidget {
  const EnterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                HeroADSDLogo(),
                const SizedBox(height: 64),
                BlueRoundedButton(
                  text: 'Enter',
                  onPress: () {
                    Navigator.push(context, const LoginScreen().getRoute());
                  },
                ),
                const SizedBox(height: 8),
                const Text(
                    'https://www.epc.ae'
                ),
              ],
            ),
          ),
        )
    );
  }
}
