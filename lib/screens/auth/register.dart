import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:webrtc_conference/cubits/login.dart';
import 'package:webrtc_conference/repositories/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegScreen extends StatelessWidget {
  const RegScreen({Key? key}) : super(key: key);

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Registration',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: Svg('assets/images/Login_Background.svg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: BlocProvider(
            create: (BuildContext context) =>
                LoginCubit(context.read<AuthenticationRepository>()),
            child: const MyCustomForm(),
          ),
        ), /**/
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? country;
  String? email;
  String? password;

  String? passwordConfirm;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        onChanged: () {
          Form.of(primaryFocus!.context!)!.save();
        },
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
                child: Container(
              height: 500.0,
              child: Column(
                children: <Widget>[
                  //ADSD logo image
                  Container(
                    child: Image.asset('assets/images/ADSD_logo.png'),
                  ),
                  //Registration text
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: RichText(
                      text: const TextSpan(
                        text: 'Registration',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  // Add TextFormFields and ElevatedButton here.
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyan,
                            width: 0.5,
                          ),
                        ),
                      ),
                      onSaved: (String? value) {
                        name = value;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyan,
                            width: 0.5,
                          ),
                        ),
                      ),
                      onSaved: (String? value) {
                        email = value;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Country',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyan,
                            width: 0.5,
                          ),
                        ),
                      ),
                      onSaved: (String? value) {
                        country = value;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyan,
                            width: 0.5,
                          ),
                        ),
                      ),
                      obscureText: true,
                      onSaved: (String? value) {
                        password = value;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    width: 300,
                    height: 50,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Confirm password',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyan,
                            width: 0.5,
                          ),
                        ),
                      ),
                      onSaved: (String? value) {
                        passwordConfirm = value;
                      },
                    ),
                  ),
                  //Confirm registration
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        save(() => context
                            .read<LoginCubit>()
                              .signUpWithBasicData(name, email, country, password, passwordConfirm));
                      },
                      child: const Text('Register'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(0, 164, 212, 1.0),
                        fixedSize: const Size(120, 20),
                      ),
                    ),
                  ),
                ],
              ),
            ))));
  }
}
