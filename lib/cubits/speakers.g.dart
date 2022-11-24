// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speakers.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SpeakersStateCWProxy {
  SpeakersState speakers(Iterable<SpeakerModel> speakers);

  SpeakersState status(SpeakersStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SpeakersState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SpeakersState(...).copyWith(id: 12, name: "My name")
  /// ````
  SpeakersState call({
    Iterable<SpeakerModel>? speakers,
    SpeakersStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSpeakersState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSpeakersState.copyWith.fieldName(...)`
class _$SpeakersStateCWProxyImpl implements _$SpeakersStateCWProxy {
  final SpeakersState _value;

  const _$SpeakersStateCWProxyImpl(this._value);

  @override
  SpeakersState speakers(Iterable<SpeakerModel> speakers) =>
      this(speakers: speakers);

  @override
  SpeakersState status(SpeakersStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SpeakersState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SpeakersState(...).copyWith(id: 12, name: "My name")
  /// ````
  SpeakersState call({
    Object? speakers = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return SpeakersState(
      speakers: speakers == const $CopyWithPlaceholder()
          ? _value.speakers
          // ignore: cast_nullable_to_non_nullable
          : speakers as Iterable<SpeakerModel>,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as SpeakersStatus,
    );
  }
}

extension $SpeakersStateCopyWith on SpeakersState {
  /// Returns a callable class that can be used as follows: `instanceOfclass SpeakersState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass SpeakersState extends Equatable.name.copyWith.fieldName(...)`.
  _$SpeakersStateCWProxy get copyWith => _$SpeakersStateCWProxyImpl(this);
}
