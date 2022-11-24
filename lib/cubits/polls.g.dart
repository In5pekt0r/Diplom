// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polls.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PollsStateCWProxy {
  PollsState polls(Iterable<PollModel> polls);

  PollsState status(PollsStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PollsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PollsState(...).copyWith(id: 12, name: "My name")
  /// ````
  PollsState call({
    Iterable<PollModel>? polls,
    PollsStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPollsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPollsState.copyWith.fieldName(...)`
class _$PollsStateCWProxyImpl implements _$PollsStateCWProxy {
  final PollsState _value;

  const _$PollsStateCWProxyImpl(this._value);

  @override
  PollsState polls(Iterable<PollModel> polls) => this(polls: polls);

  @override
  PollsState status(PollsStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PollsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PollsState(...).copyWith(id: 12, name: "My name")
  /// ````
  PollsState call({
    Object? polls = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return PollsState(
      polls: polls == const $CopyWithPlaceholder()
          ? _value.polls
          // ignore: cast_nullable_to_non_nullable
          : polls as Iterable<PollModel>,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as PollsStatus,
    );
  }
}

extension $PollsStateCopyWith on PollsState {
  /// Returns a callable class that can be used as follows: `instanceOfclass PollsState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass PollsState extends Equatable.name.copyWith.fieldName(...)`.
  _$PollsStateCWProxy get copyWith => _$PollsStateCWProxyImpl(this);
}
