// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_agenda.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PersonalAgendaStateCWProxy {
  PersonalAgendaState agenda(Iterable<EventModel> agenda);

  PersonalAgendaState status(PersonalAgendaStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PersonalAgendaState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PersonalAgendaState(...).copyWith(id: 12, name: "My name")
  /// ````
  PersonalAgendaState call({
    Iterable<EventModel>? agenda,
    PersonalAgendaStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPersonalAgendaState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPersonalAgendaState.copyWith.fieldName(...)`
class _$PersonalAgendaStateCWProxyImpl implements _$PersonalAgendaStateCWProxy {
  final PersonalAgendaState _value;

  const _$PersonalAgendaStateCWProxyImpl(this._value);

  @override
  PersonalAgendaState agenda(Iterable<EventModel> agenda) =>
      this(agenda: agenda);

  @override
  PersonalAgendaState status(PersonalAgendaStatus status) =>
      this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PersonalAgendaState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PersonalAgendaState(...).copyWith(id: 12, name: "My name")
  /// ````
  PersonalAgendaState call({
    Object? agenda = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return PersonalAgendaState(
      agenda: agenda == const $CopyWithPlaceholder()
          ? _value.agenda
          // ignore: cast_nullable_to_non_nullable
          : agenda as Iterable<EventModel>,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as PersonalAgendaStatus,
    );
  }
}

extension $PersonalAgendaStateCopyWith on PersonalAgendaState {
  /// Returns a callable class that can be used as follows: `instanceOfclass PersonalAgendaState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass PersonalAgendaState extends Equatable.name.copyWith.fieldName(...)`.
  _$PersonalAgendaStateCWProxy get copyWith =>
      _$PersonalAgendaStateCWProxyImpl(this);
}
