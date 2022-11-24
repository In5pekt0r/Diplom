import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:webrtc_conference/cubits/profile.dart';
import 'package:webrtc_conference/repositories/database.dart';
import 'package:webrtc_conference/screens/home.dart';

import '../../main.dart';
import '../../models/profile.dart';

class LoadProfileScreen extends StatelessWidget {
  const LoadProfileScreen({Key? key}) : super(key: key);

  Route<T> getRoute<T>() {
    return buildRoute(
        '/Load Profile',
        builder: (_) => this
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _LoadProfileBody(),
    );
  }
}

class _LoadProfileBody extends StatefulWidget {
  @override
  _LoadProfileBodyState createState() => _LoadProfileBodyState();
}

class _LoadProfileBodyState extends State<_LoadProfileBody> {
  void Function(ProfileModel)? pushHomeScreen;

  @override
  void initState() {
    super.initState();
    _run();
  }

  void _run() async {
    context.read<DatabaseRepository>().initializeService();
    _load();
  }

  void _load() {
    load(() => context.read<ProfileCubit>().load());
    pushHomeScreen = (profile) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.push(context, HomeScreen(profile: profile).getRoute());
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (ProfileState previous, ProfileState current) {
        return previous.status != current.status;
      },
      builder: (BuildContext context, ProfileState state) {
        final cases = {
          ProfileStatus.initial: () => Container(),
          ProfileStatus.loading: () =>
              const Center(child: CircularProgressIndicator()),
          ProfileStatus.error: () {
            return Center(
                child: FloatingActionButton(
                  onPressed: () {
                    BotToast.cleanAll();
                    _load();
                  },
                  child: const Icon(Icons.replay),
                ));
          },
          ProfileStatus.ready: () {
            if (pushHomeScreen != null) pushHomeScreen!(state.profile!);
            pushHomeScreen = null;
            return const Center(child: CircularProgressIndicator());
          },
        };
        assert(cases.length == ProfileStatus.values.length);
        return cases[state.status]!();
      },
    );
  }
}
