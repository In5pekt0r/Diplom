// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SpeakerStateCWProxy {
  SpeakerState sessions(Iterable<EventModel> sessions);

  SpeakerState speaker(SpeakerModel? speaker);

  SpeakerState status(SpeakerStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SpeakerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SpeakerState(...).copyWith(id: 12, name: "My name")
  /// ````
  SpeakerState call({
    Iterable<EventModel>? sessions,
    SpeakerModel? speaker,
    SpeakerStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSpeakerState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSpeakerState.copyWith.fieldName(...)`
class _$SpeakerStateCWProxyImpl implements _$SpeakerStateCWProxy {
  final SpeakerState _value;

  const _$SpeakerStateCWProxyImpl(this._value);

  @override
  SpeakerState sessions(Iterable<EventModel> sessions) =>
      this(sessions: sessions);

  @override
  SpeakerState speaker(SpeakerModel? speaker) => this(speaker: speaker);

  @override
  SpeakerState status(SpeakerStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SpeakerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SpeakerState(...).copyWith(id: 12, name: "My name")
  /// ````
  SpeakerState call({
    Object? sessions = const $CopyWithPlaceholder(),
    Object? speaker = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return SpeakerState(
      sessions: sessions == const $CopyWithPlaceholder()
          ? _value.sessions
          // ignore: cast_nullable_to_non_nullable
          : sessions as Iterable<EventModel>,
      speaker: speaker == const $CopyWithPlaceholder()
          ? _value.speaker
          // ignore: cast_nullable_to_non_nullable
          : speaker as SpeakerModel?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as SpeakerStatus,
    );
  }
}

extension $SpeakerStateCopyWith on SpeakerState {
  /// Returns a callable class that can be used as follows: `instanceOfclass SpeakerState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass SpeakerState extends Equatable.name.copyWith.fieldName(...)`.
  _$SpeakerStateCWProxy get copyWith => _$SpeakerStateCWProxyImpl(this);
}
