// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendees.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendeesStateCWProxy {
  AttendeesState attendees(Iterable<AttendeeModel> attendees);

  AttendeesState status(AttendeesStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendeesState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendeesState(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendeesState call({
    Iterable<AttendeeModel>? attendees,
    AttendeesStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendeesState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendeesState.copyWith.fieldName(...)`
class _$AttendeesStateCWProxyImpl implements _$AttendeesStateCWProxy {
  final AttendeesState _value;

  const _$AttendeesStateCWProxyImpl(this._value);

  @override
  AttendeesState attendees(Iterable<AttendeeModel> attendees) =>
      this(attendees: attendees);

  @override
  AttendeesState status(AttendeesStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendeesState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendeesState(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendeesState call({
    Object? attendees = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return AttendeesState(
      attendees: attendees == const $CopyWithPlaceholder()
          ? _value.attendees
          // ignore: cast_nullable_to_non_nullable
          : attendees as Iterable<AttendeeModel>,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AttendeesStatus,
    );
  }
}

extension $AttendeesStateCopyWith on AttendeesState {
  /// Returns a callable class that can be used as follows: `instanceOfclass AttendeesState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass AttendeesState extends Equatable.name.copyWith.fieldName(...)`.
  _$AttendeesStateCWProxy get copyWith => _$AttendeesStateCWProxyImpl(this);
}
