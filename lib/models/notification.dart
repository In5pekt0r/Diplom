import 'dart:core';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
@CopyWith()
class NotificationModel {
  NotificationModel({
    required this.id,
    required this.date,
    required this.text
  });

  final int id;
  final DateTime date;
  final String text;

  static List<NotificationModel> getRandom({int n = 6, Faker? faker}) {
    final _faker = faker ?? Faker();
    return List<NotificationModel>.generate(n, (i) =>
      NotificationModel(
        id: i,
        date: DateTime.now().subtract(Duration(minutes: i * 30)),
        text: _faker.conference.name()
      )
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NotificationModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}

extension IterableNotificationModel on Iterable<NotificationModel> {
  Iterable<Map<String, dynamic>> toJson() => map((e) => e.toJson());
}
