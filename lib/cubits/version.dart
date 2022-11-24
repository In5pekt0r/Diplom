import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:version/version.dart';

part 'version.g.dart';

@Deprecated('not needed yet')
class VersionCubit extends Cubit<VersionState> {
  VersionCubit(): super(const VersionState());

  // final RemoteConfig _remoteConfig;

  Future<void> load() async {
    if (state.status == VersionStatus.loading) return;
    emit(state.copyWith(status: VersionStatus.loading));
    try {
      late String packageValue;
      if (state.packageValue == null) {
        final packageInfo = await PackageInfo.fromPlatform();
        packageValue = '${packageInfo.version}+${packageInfo.buildNumber}';
      }
      // await _remoteConfig.fetch(expiration: kRemoteConfigExpiration);
      // await _remoteConfig.activateFetched();
      const releaseValue = '1';//_remoteConfig.getString('release_value');
      const supportValue = '1';//_remoteConfig.getString('support_value');
      emit(state.copyWith(
        packageValue: packageValue,
        releaseValue: releaseValue,
        supportValue: supportValue,
        status: VersionStatus.ready,
      ));
    } catch (error) {
      debugPrint('$error');
      emit(state.copyWith(status: VersionStatus.error));
      rethrow;
    }
  }
}

enum VersionStatus { initial, loading, error, ready }

@CopyWith()
class VersionState extends Equatable {
  const VersionState({
    this.packageValue,
    this.releaseValue,
    this.supportValue,
    this.status = VersionStatus.initial,
  });

  final String? packageValue;
  final String? releaseValue;
  final String? supportValue;
  final VersionStatus status;

  @override
  List<Object?> get props => [
    packageValue,
    releaseValue,
    supportValue,
    status,
  ];

  bool get isValidPackageValue =>
          supportValue != null &&
          supportValue!.isNotEmpty &&
          packageValue != null &&
          Version.parse(supportValue) <= Version.parse(packageValue);

  bool get hasUpdate =>
      Version.parse(releaseValue) > Version.parse(packageValue);
}
