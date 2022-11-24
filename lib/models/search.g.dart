// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SearchModelCWProxy {
  SearchModel agenda(Iterable<EventModel> agenda);

  SearchModel attendees(Iterable<AttendeeModel> attendees);

  SearchModel speakers(Iterable<SpeakerModel> speakers);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchModel(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchModel call({
    Iterable<EventModel>? agenda,
    Iterable<AttendeeModel>? attendees,
    Iterable<SpeakerModel>? speakers,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSearchModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSearchModel.copyWith.fieldName(...)`
class _$SearchModelCWProxyImpl implements _$SearchModelCWProxy {
  final SearchModel _value;

  const _$SearchModelCWProxyImpl(this._value);

  @override
  SearchModel agenda(Iterable<EventModel> agenda) => this(agenda: agenda);

  @override
  SearchModel attendees(Iterable<AttendeeModel> attendees) =>
      this(attendees: attendees);

  @override
  SearchModel speakers(Iterable<SpeakerModel> speakers) =>
      this(speakers: speakers);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchModel(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchModel call({
    Object? agenda = const $CopyWithPlaceholder(),
    Object? attendees = const $CopyWithPlaceholder(),
    Object? speakers = const $CopyWithPlaceholder(),
  }) {
    return SearchModel(
      agenda: agenda == const $CopyWithPlaceholder()
          ? _value.agenda
          // ignore: cast_nullable_to_non_nullable
          : agenda as Iterable<EventModel>,
      attendees: attendees == const $CopyWithPlaceholder()
          ? _value.attendees
          // ignore: cast_nullable_to_non_nullable
          : attendees as Iterable<AttendeeModel>,
      speakers: speakers == const $CopyWithPlaceholder()
          ? _value.speakers
          // ignore: cast_nullable_to_non_nullable
          : speakers as Iterable<SpeakerModel>,
    );
  }
}

extension $SearchModelCopyWith on SearchModel {
  /// Returns a callable class that can be used as follows: `instanceOfclass SearchModel.name.copyWith(...)` or like so:`instanceOfclass SearchModel.name.copyWith.fieldName(...)`.
  _$SearchModelCWProxy get copyWith => _$SearchModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
      agenda: (json['agenda'] as List<dynamic>?)
              ?.map((e) => EventModel.fromJson(e as Map<String, dynamic>)) ??
          const [],
      speakers: (json['speakers'] as List<dynamic>?)
              ?.map((e) => SpeakerModel.fromJson(e as Map<String, dynamic>)) ??
          const [],
      attendees: (json['attendees'] as List<dynamic>?)
              ?.map((e) => AttendeeModel.fromJson(e as Map<String, dynamic>)) ??
          const [],
    );

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'agenda': instance.agenda.toList(),
      'speakers': instance.speakers.toList(),
      'attendees': instance.attendees.toList(),
    };
