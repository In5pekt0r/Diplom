// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EventStateCWProxy {
  EventState event(EventModel? event);

  EventState speakers(Iterable<SpeakerModel> speakers);

  EventState status(EventStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EventState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EventState(...).copyWith(id: 12, name: "My name")
  /// ````
  EventState call({
    EventModel? event,
    Iterable<SpeakerModel>? speakers,
    EventStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEventState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEventState.copyWith.fieldName(...)`
class _$EventStateCWProxyImpl implements _$EventStateCWProxy {
  final EventState _value;

  const _$EventStateCWProxyImpl(this._value);

  @override
  EventState event(EventModel? event) => this(event: event);

  @override
  EventState speakers(Iterable<SpeakerModel> speakers) =>
      this(speakers: speakers);

  @override
  EventState status(EventStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EventState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EventState(...).copyWith(id: 12, name: "My name")
  /// ````
  EventState call({
    Object? event = const $CopyWithPlaceholder(),
    Object? speakers = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return EventState(
      event: event == const $CopyWithPlaceholder()
          ? _value.event
          // ignore: cast_nullable_to_non_nullable
          : event as EventModel?,
      speakers: speakers == const $CopyWithPlaceholder()
          ? _value.speakers
          // ignore: cast_nullable_to_non_nullable
          : speakers as Iterable<SpeakerModel>,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as EventStatus,
    );
  }
}

extension $EventStateCopyWith on EventState {
  /// Returns a callable class that can be used as follows: `instanceOfclass EventState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass EventState extends Equatable.name.copyWith.fieldName(...)`.
  _$EventStateCWProxy get copyWith => _$EventStateCWProxyImpl(this);
}
