// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VersionStateCWProxy {
  VersionState packageValue(String? packageValue);

  VersionState releaseValue(String? releaseValue);

  VersionState status(VersionStatus status);

  VersionState supportValue(String? supportValue);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionState call({
    String? packageValue,
    String? releaseValue,
    VersionStatus? status,
    String? supportValue,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVersionState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVersionState.copyWith.fieldName(...)`
class _$VersionStateCWProxyImpl implements _$VersionStateCWProxy {
  final VersionState _value;

  const _$VersionStateCWProxyImpl(this._value);

  @override
  VersionState packageValue(String? packageValue) =>
      this(packageValue: packageValue);

  @override
  VersionState releaseValue(String? releaseValue) =>
      this(releaseValue: releaseValue);

  @override
  VersionState status(VersionStatus status) => this(status: status);

  @override
  VersionState supportValue(String? supportValue) =>
      this(supportValue: supportValue);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionState call({
    Object? packageValue = const $CopyWithPlaceholder(),
    Object? releaseValue = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? supportValue = const $CopyWithPlaceholder(),
  }) {
    return VersionState(
      packageValue: packageValue == const $CopyWithPlaceholder()
          ? _value.packageValue
          // ignore: cast_nullable_to_non_nullable
          : packageValue as String?,
      releaseValue: releaseValue == const $CopyWithPlaceholder()
          ? _value.releaseValue
          // ignore: cast_nullable_to_non_nullable
          : releaseValue as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as VersionStatus,
      supportValue: supportValue == const $CopyWithPlaceholder()
          ? _value.supportValue
          // ignore: cast_nullable_to_non_nullable
          : supportValue as String?,
    );
  }
}

extension $VersionStateCopyWith on VersionState {
  /// Returns a callable class that can be used as follows: `instanceOfclass VersionState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass VersionState extends Equatable.name.copyWith.fieldName(...)`.
  _$VersionStateCWProxy get copyWith => _$VersionStateCWProxyImpl(this);
}
