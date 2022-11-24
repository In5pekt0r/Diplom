// import 'package:bot_toast/bot_toast.dart';
import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


@Deprecated('deprecated')
T getBloc<T extends Cubit<Object>>(BuildContext context,
        {bool listen = false}) =>
    BlocProvider.of<T>(context, listen: listen);

@Deprecated('deprecated')
T getRepository<T>(BuildContext context) => RepositoryProvider.of<T>(context);

class RepeatableAction implements Exception {}

class ValidationException implements Exception {
  ValidationException(this.message);
  final String message;
  @override String toString() => message;
}

void load(Future<void> Function() future) async {
  await Future.delayed(Duration.zero); // for render initial state
  runZonedGuarded(() async {
    await future();
  }, (error, stackTrace) {
    print('**** runZonedGuarded inside load ****');
    print('$error');
    // print('$stackTrace');
    BotToast.showNotification(
      crossPage: false,
      title: (_) => Text('$error'),
      trailing: (Function close) => ElevatedButton(
        onLongPress: () {}, // чтобы сократить время для splashColor
        onPressed: () {
          close();
          save(future);
        },
        child: const Text('REPEAT'),
      ),
    );
  });
}

void loadNonRepeatable(Future<void> Function() future) async {
  await Future.delayed(Duration.zero); // for render initial state
  runZonedGuarded(() async {
    await future();
  }, (error, stackTrace) {
    print('**** runZonedGuarded inside loadNonRepeatable ****');
    print('$error');
    // print('$stackTrace');
    BotToast.showNotification(
      crossPage: false,
      title: (_) => Text('$error'),
    );
  });
}

void save(Future<void> Function() future) async {
  runZonedGuarded(() async {
    BotToast.showLoading();
    try {
      await future();
    } finally {
      BotToast.closeAllLoading();
    }
  }, (error, stackTrace) {
    print('**** runZonedGuarded inside save ****');
    print('$error');
    // print('$stackTrace');
    if (error is RepeatableAction) {
      BotToast.showNotification(
        // crossPage: true, // by default - important value!!!
        title: (_) => Text('$error'),
        trailing: (Function close) => ElevatedButton(
          onLongPress: () {}, // чтобы сократить время для splashColor
          onPressed: () {
            close();
            save(future);
          },
          child: const Text('REPEAT'),
        ),
      );
    } else {
      BotToast.showNotification(
        crossPage: false,
        title: (_) => Text('$error'),
      );
    }
  });
}

T? normalizeOne<T>({
  required Map<String, dynamic> data,
  String? root,
  dynamic Function(dynamic rawJson)? toRoot,
  required T Function(Map<String, dynamic> json) convert,
}) {
  final hasRoot = root != null && root.isNotEmpty;
  final hasToRoot = toRoot != null;
  assert(!(hasRoot && hasToRoot), 'Assign "root" or "toRoot" or nothing');
  final rawJson = hasRoot
      ? data[root]
      : hasToRoot
      ? toRoot!(data)
      : data;
  final json = rawJson as Map<String, dynamic>;
  return convert(json);
}