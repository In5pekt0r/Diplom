import 'dart:core';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:webrtc_conference/models/event.dart';
import 'package:webrtc_conference/models/speaker.dart';

import 'attendee.dart';

part 'search.g.dart';

@JsonSerializable()
@CopyWith()
class SearchModel {
  SearchModel({
    this.agenda = const [],
    this.speakers = const [],
    this.attendees = const [],
  });

  final Iterable<EventModel> agenda;
  final Iterable<SpeakerModel> speakers;
  final Iterable<AttendeeModel> attendees;

  static List<SearchModel> getRandom({int n = 6, Faker? faker}) {
    final _faker = faker ?? Faker();
    return List<SearchModel>.generate(n, (i) =>
      SearchModel(
        agenda: EventModel.getRandom(faker: _faker),
        speakers: SpeakerModel.getRandom(faker: _faker),
        attendees: AttendeeModel.getRandom(faker: _faker),
      )
    );
  }

  factory SearchModel.fromJson(Map<String, dynamic> json) => _$SearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}

extension IterableSearchModel on Iterable<SearchModel> {
  Iterable<Map<String, dynamic>> toJson() => map((e) => e.toJson());
}
