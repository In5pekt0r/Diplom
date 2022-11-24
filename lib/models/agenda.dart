import 'dart:core';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:webrtc_conference/models/event.dart';

part 'agenda.g.dart';

@JsonSerializable()
@CopyWith()
class AgendaModel {
  AgendaModel({
    required this.id,
    required this.date,
    required this.events
  });

  final int id;
  final DateTime date;
  Iterable<EventModel> events;

  static List<AgendaModel> getRandom({int n = 6, Faker? faker}) {
    int prevCount = 0;
    return List<AgendaModel>.generate(n, (i) {
      final agenda = AgendaModel(
        id: i,
        date: DateTime.now().add(Duration(days: i)),
        events: EventModel.getRandom(
            now: DateTime.now().add(Duration(days: i)),
            faker: faker,
            offset: prevCount
        )
      );
      prevCount += agenda.events.length;
      return agenda;
    });
  }

  factory AgendaModel.fromJson(Map<String, dynamic> json) => _$AgendaModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgendaModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgendaModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

extension IterableAgendaModel on Iterable<AgendaModel> {
  Iterable<Map<String, dynamic>> toJson() => map((e) => e.toJson());
}
