// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProfileStateCWProxy {
  ProfileState profile(ProfileModel? profile);

  ProfileState status(ProfileStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileState(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileState call({
    ProfileModel? profile,
    ProfileStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfileState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfileState.copyWith.fieldName(...)`
class _$ProfileStateCWProxyImpl implements _$ProfileStateCWProxy {
  final ProfileState _value;

  const _$ProfileStateCWProxyImpl(this._value);

  @override
  ProfileState profile(ProfileModel? profile) => this(profile: profile);

  @override
  ProfileState status(ProfileStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileState(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileState call({
    Object? profile = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return ProfileState(
      profile: profile == const $CopyWithPlaceholder()
          ? _value.profile
          // ignore: cast_nullable_to_non_nullable
          : profile as ProfileModel?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ProfileStatus,
    );
  }
}

extension $ProfileStateCopyWith on ProfileState {
  /// Returns a callable class that can be used as follows: `instanceOfclass ProfileState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass ProfileState extends Equatable.name.copyWith.fieldName(...)`.
  _$ProfileStateCWProxy get copyWith => _$ProfileStateCWProxyImpl(this);
}
