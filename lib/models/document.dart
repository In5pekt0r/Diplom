import 'dart:core';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable()
@CopyWith()
class DocumentModel {
  DocumentModel({
    required this.id,
    required this.name,
    required this.link,
  });

  final int id;
  final String name;
  final String link;

  static List<DocumentModel> getRandom({int n = 6, DateTime? now, Faker? faker, int offset = 0}) {
    Faker _faker = faker ?? Faker();
    return List<DocumentModel>
      .generate(n, (i) => DocumentModel(
        id: offset + i,
        name: _faker.conference.name(),
        link: 'https://google.com'
      )
    );
  }

  factory DocumentModel.fromJson(Map<String, dynamic> json) => _$DocumentModelFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DocumentModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

extension IterableDocumentModel on Iterable<DocumentModel> {
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
