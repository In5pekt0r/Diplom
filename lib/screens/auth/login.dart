import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:webrtc_conference/cubits/login.dart';
import 'package:webrtc_conference/repositories/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/widgets/hero_adsd_logo.dart';

import '../../widgets/blue_rounded_button.dart';
import '../../widgets/blue_rounded_text_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Login',
      builder: (_) => this,
    );
  }

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
          child: BlocProvider(
            create: (BuildContext context) =>
                LoginCubit(context.read<AuthenticationRepository>()),
            child: const LoginForm(),
          ),
        )
    );
  }
}

// Define a custom Form widget.
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _LoginFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  bool get loginButtonNotAvailable =>
      (email == null || email!.isEmpty ||
      password == null || password!.isEmpty);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              const Spacer(),
              HeroADSDLogo(),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                onChanged: () {
                  Form.of(primaryFocus!.context!)!.save();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      BlueRoundedTextInput(
                        hint: 'Email',
                        icon: Icons.mail_outline,
                        onSaved: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      BlueRoundedTextInput(
                        hint: 'Password',
                        icon: Icons.vpn_key_rounded,
                        onSaved: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Expanded(
                              child: BlueRoundedButton(
                                text: 'Login',
                                dense: true,
                                onPress:
                                    (loginButtonNotAvailable) ? null :
                                () {
                                  save(() => context
                                      .read<LoginCubit>()
                                      .logInWithEmailAndPassword(email, password)
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: BlueRoundedButton(
                                text: 'Register',
                                dense: true,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
