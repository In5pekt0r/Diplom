import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:state_persistence/state_persistence.dart';
import 'package:webrtc_conference/common/email_password_auth.dart';
import 'package:webrtc_conference/common/web_service.dart';
import 'package:webrtc_conference/cubits/attendees.dart';
import 'package:webrtc_conference/cubits/documents.dart';
import 'package:webrtc_conference/cubits/news.dart';
import 'package:webrtc_conference/cubits/polls.dart';
import 'package:webrtc_conference/cubits/profile.dart';
import 'package:webrtc_conference/cubits/search.dart';
import 'package:webrtc_conference/repositories/authentication.dart';
import 'package:webrtc_conference/repositories/database.dart';
import 'package:webrtc_conference/screens/auth/load_profile.dart';
import 'package:webrtc_conference/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/screens/auth/welcome.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'cubits/agenda.dart';
import 'cubits/authentication.dart';
import 'cubits/event.dart';
import 'cubits/notifications.dart';
import 'cubits/personal_agenda.dart';
import 'cubits/speaker.dart';
import 'cubits/speakers.dart';

// MOCK VARIABLE
const mockAuth = true;
const mockServer = true;

/*
TODO: Place different app bar on each tab bar
TODO: Add Russian, Arab and smth else localization
 */

final navigatorKey = GlobalKey<NavigatorState>();
NavigatorState? get navigator => navigatorKey.currentState;

late PersistedData? appState;

void main() {
  /*
    Things to do before starting the application
    1. Configure error handler by setting FlutterError.onError
    2. runZonedGuarded<Future<void>> with:
      1) WidgetsFlutterBinding.ensureInitialized()
      2) Configure notifications system
      3) Networking initialization
      4) Locale detection
      5) Storage setup
      6) runApp
   */
  runZonedGuarded(() async {
    await initializeDateFormatting('en_US');
    runApp(
      App(
        authenticationRepository: AuthenticationRepository(
          emailPasswordAuth:
            mockAuth ? MockEmailPasswordAuth.instance : null
        ),
        databaseRepository: DatabaseRepository(
          createService:
              mockServer ? () => MockWebService() : null
        ),
      )
    );
  }, (error, stackTrace) {
    debugPrint('**** runZonedGuarded ****');
    debugPrint('$error');
    debugPrint('$stackTrace');
  });
}

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.databaseRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final DatabaseRepository databaseRepository;

  @override
  Widget build(BuildContext context) {
    Widget result = const AppView();

    result = BlocProvider(
      create: (BuildContext context) {
        return AuthenticationCubit(authenticationRepository);
      },
      child: result,
    );
    result = RepositoryProvider.value(
      value: authenticationRepository,
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return ProfileCubit(databaseRepository);
      },
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return AgendaCubit(databaseRepository);
      },
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return SpeakersCubit(databaseRepository);
      },
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return AttendeesCubit(databaseRepository);
      },
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return PollsCubit(databaseRepository);
      },
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return EventCubit(databaseRepository);
      },
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return SpeakerCubit(databaseRepository);
      },
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return NotificationsCubit(databaseRepository);
      },
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return SearchCubit(databaseRepository);
      },
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return PersonalAgendaCubit(databaseRepository);
      },
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return NewsCubit(databaseRepository);
      },
      child: result,
    );
    result = BlocProvider(
      create: (BuildContext context) {
        return DocumentsCubit(databaseRepository);
      },
      child: result,
    );
    result = RepositoryProvider.value(
      value: databaseRepository,
      child: result,
    );

    return result;
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget result;

    result = MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      title: 'Conference organizer',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      navigatorObservers: <NavigatorObserver>[
        BotToastNavigatorObserver(),
      ],
      builder: (BuildContext context, Widget? child) {
        Widget result = child!;

        result = BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (BuildContext context, AuthenticationState state) {
            final cases = {
              AuthenticationStatus.authenticated: () {
                navigator?.pushAndRemoveUntil<void>(
                  const LoadProfileScreen().getRoute(),
                  (Route route) => false,
                );
              },
              AuthenticationStatus.unauthenticated: () {
                navigator?.pushAndRemoveUntil<void>(
                  const WelcomeScreen().getRoute(),
                  (Route route) => false,
                );
              },
              AuthenticationStatus.unknown: () {},
            };
            assert(cases.length == AuthenticationStatus.values.length);
            cases[state.status]!();
          },
          child: result,
        );

        result = BotToastInit()(context, result);
        if (mockServer) result = result.mockBanner();
        return result;
      },
      onGenerateRoute: (RouteSettings settings) => SplashScreen().getRoute(),
    );

    return result;
  }
}

extension CustomBanner on Widget {
  Widget mockBanner() {
    return Stack(
      children: [
        this,
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.only(top: 48, right: 48),
            child: const Banner(
              message: "Mock",
              location: BannerLocation.bottomStart,
            ),
          ),
        ),
      ],
    );
  }
}
