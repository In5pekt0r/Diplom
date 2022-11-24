// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AgendaModelCWProxy {
  AgendaModel date(DateTime date);

  AgendaModel events(Iterable<EventModel> events);

  AgendaModel id(int id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AgendaModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AgendaModel(...).copyWith(id: 12, name: "My name")
  /// ````
  AgendaModel call({
    DateTime? date,
    Iterable<EventModel>? events,
    int? id,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAgendaModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAgendaModel.copyWith.fieldName(...)`
class _$AgendaModelCWProxyImpl implements _$AgendaModelCWProxy {
  final AgendaModel _value;

  const _$AgendaModelCWProxyImpl(this._value);

  @override
  AgendaModel date(DateTime date) => this(date: date);

  @override
  AgendaModel events(Iterable<EventModel> events) => this(events: events);

  @override
  AgendaModel id(int id) => this(id: id);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AgendaModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AgendaModel(...).copyWith(id: 12, name: "My name")
  /// ````
  AgendaModel call({
    Object? date = const $CopyWithPlaceholder(),
    Object? events = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return AgendaModel(
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime,
      events: events == const $CopyWithPlaceholder()
          ? _value.events
          // ignore: cast_nullable_to_non_nullable
          : events as Iterable<EventModel>,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
    );
  }
}

extension $AgendaModelCopyWith on AgendaModel {
  /// Returns a callable class that can be used as follows: `instanceOfclass AgendaModel.name.copyWith(...)` or like so:`instanceOfclass AgendaModel.name.copyWith.fieldName(...)`.
  _$AgendaModelCWProxy get copyWith => _$AgendaModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgendaModel _$AgendaModelFromJson(Map<String, dynamic> json) => AgendaModel(
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
      events: (json['events'] as List<dynamic>)
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>)),
    );

Map<String, dynamic> _$AgendaModelToJson(AgendaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'events': instance.events.toList(),
    };
