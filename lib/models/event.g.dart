// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EventModelCWProxy {
  EventModel description(String description);

  EventModel endDate(DateTime endDate);

  EventModel id(int id);

  EventModel polls(Iterable<int> polls);

  EventModel speakers(Iterable<int> speakers);

  EventModel startDate(DateTime startDate);

  EventModel title(String title);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EventModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EventModel(...).copyWith(id: 12, name: "My name")
  /// ````
  EventModel call({
    String? description,
    DateTime? endDate,
    int? id,
    Iterable<int>? polls,
    Iterable<int>? speakers,
    DateTime? startDate,
    String? title,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEventModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEventModel.copyWith.fieldName(...)`
class _$EventModelCWProxyImpl implements _$EventModelCWProxy {
  final EventModel _value;

  const _$EventModelCWProxyImpl(this._value);

  @override
  EventModel description(String description) => this(description: description);

  @override
  EventModel endDate(DateTime endDate) => this(endDate: endDate);

  @override
  EventModel id(int id) => this(id: id);

  @override
  EventModel polls(Iterable<int> polls) => this(polls: polls);

  @override
  EventModel speakers(Iterable<int> speakers) => this(speakers: speakers);

  @override
  EventModel startDate(DateTime startDate) => this(startDate: startDate);

  @override
  EventModel title(String title) => this(title: title);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EventModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EventModel(...).copyWith(id: 12, name: "My name")
  /// ````
  EventModel call({
    Object? description = const $CopyWithPlaceholder(),
    Object? endDate = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? polls = const $CopyWithPlaceholder(),
    Object? speakers = const $CopyWithPlaceholder(),
    Object? startDate = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
  }) {
    return EventModel(
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      endDate: endDate == const $CopyWithPlaceholder()
          ? _value.endDate
          // ignore: cast_nullable_to_non_nullable
          : endDate as DateTime,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      polls: polls == const $CopyWithPlaceholder()
          ? _value.polls
          // ignore: cast_nullable_to_non_nullable
          : polls as Iterable<int>,
      speakers: speakers == const $CopyWithPlaceholder()
          ? _value.speakers
          // ignore: cast_nullable_to_non_nullable
          : speakers as Iterable<int>,
      startDate: startDate == const $CopyWithPlaceholder()
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as DateTime,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
    );
  }
}

extension $EventModelCopyWith on EventModel {
  /// Returns a callable class that can be used as follows: `instanceOfclass EventModel.name.copyWith(...)` or like so:`instanceOfclass EventModel.name.copyWith.fieldName(...)`.
  _$EventModelCWProxy get copyWith => _$EventModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      speakers: (json['speakers'] as List<dynamic>).map((e) => e as int),
      polls: (json['polls'] as List<dynamic>).map((e) => e as int),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'speakers': instance.speakers.toList(),
      'polls': instance.polls.toList(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
