// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AgendaStateCWProxy {
  AgendaState agenda(Iterable<EventModel> agenda);

  AgendaState status(AgendaStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AgendaState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AgendaState(...).copyWith(id: 12, name: "My name")
  /// ````
  AgendaState call({
    Iterable<EventModel>? agenda,
    AgendaStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAgendaState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAgendaState.copyWith.fieldName(...)`
class _$AgendaStateCWProxyImpl implements _$AgendaStateCWProxy {
  final AgendaState _value;

  const _$AgendaStateCWProxyImpl(this._value);

  @override
  AgendaState agenda(Iterable<EventModel> agenda) => this(agenda: agenda);

  @override
  AgendaState status(AgendaStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AgendaState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AgendaState(...).copyWith(id: 12, name: "My name")
  /// ````
  AgendaState call({
    Object? agenda = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return AgendaState(
      agenda: agenda == const $CopyWithPlaceholder()
          ? _value.agenda
          // ignore: cast_nullable_to_non_nullable
          : agenda as Iterable<EventModel>,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as AgendaStatus,
    );
  }
}

extension $AgendaStateCopyWith on AgendaState {
  /// Returns a callable class that can be used as follows: `instanceOfclass AgendaState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass AgendaState extends Equatable.name.copyWith.fieldName(...)`.
  _$AgendaStateCWProxy get copyWith => _$AgendaStateCWProxyImpl(this);
}
