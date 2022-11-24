import 'package:flutter/material.dart';

import '../widgets/adsd_app_bar.dart';

class TitleManager {
  TitleManager({required this.appBarKey});
  final GlobalKey<ADSDAppBarState> appBarKey;
  void setTitleWithString({required String title, required bool isRoot, bool insideSetState = false}) {
    // print('titleManager\tsetTitleWithString\t$title\tstart');
    if (appBarKey.currentState != null) {
      // print('titleManager\tsetTitleWithString\t$title\tstate is not null');
      appBarKey.currentState!.setTitle(
          title: title, isRoot: isRoot, insideSetState: insideSetState);
    } else {
      // print('titleManager\tsetTitleWithString\t$title\tstate is null');
      Future.delayed(const Duration(milliseconds: 100), () {
        if (appBarKey.currentState!.isTitleNotSet) {
          // print('titleManager\tsetTitleWithString\t$title\ttitle not set');
          setTitleWithString(
              title: title, isRoot: isRoot, insideSetState: insideSetState);
        }
      });
    }
  }

  void setTitleWithRoute(Route? route) {
    // print('titleManager\tsetTitleWithRoute\t${route?.settings.name}\tstart');
    if (route == null) { return; }
    if (route.settings.name == null) { return; }
    final pathComponents = route.settings.name!.split('/');
    final newTitle = pathComponents.last;
    final isRoot = route.isFirst;
    setTitleWithString(title: newTitle, isRoot: isRoot);
    // print('titleManager\tsetTitleWithRoute\t${route.settings.name}\tend');
  }
}