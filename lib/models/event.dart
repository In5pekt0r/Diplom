import 'dart:core';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

/// Json representation:
/// [
///   {
///     "title": "string",
///     "description": "string",
///     "speakers": [1, 2, 3],
///     "polls": [1, 2],
///     "start_date": "2021-11-15T00:23:45Z",
///     "end_date": "2021-11-16T00:23:45Z"
///   }
/// ]
@JsonSerializable()
@CopyWith()
class EventModel {
  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.speakers,
    required this.polls,
    required this.startDate,
    required this.endDate,
  });

  final int id;
  final String title;
  final String description;
  Iterable<int> speakers;
  Iterable<int> polls;
  final DateTime startDate;
  final DateTime endDate;

  static List<EventModel> getRandom({int n = 6, DateTime? now, Faker? faker, int offset = 0}) {
    Faker _faker = faker ?? Faker();
    final _now = now ?? DateTime.now();
    final todayMorning = DateTime.utc(_now.year, _now.month, _now.day, 09, 00);

    return List<EventModel>.generate(n, (i) => EventModel(
          id: offset + i,
          title: _faker.conference.name(),
          description: _faker.lorem.sentences(_faker.randomGenerator.integer(20)).join(' '),
          speakers: [],
          polls: [],
          startDate: todayMorning.add(Duration(hours: i)),
          endDate: todayMorning.add(Duration(hours: i+1)),
        )
      );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

extension IterableAgendaModel on Iterable<EventModel> {
  Iterable<Map<String, dynamic>> toJson() =>
      map((e) => e.toJson());
}

extension DateAndTimeFromDateTime on DateTime {
  String toTime() => DateFormat.Hm().format(this);
  String toDate() => DateFormat('dd MMM yyyy').format(this);
  String toShortMonth() => DateFormat.MMM().format(this);
  String toShortDay() => DateFormat.d().format(this);
}

extension StringMultiplication on String {
  String operator *(int mul) => List<String>.generate(mul, (i) => this).join('; ');
}
