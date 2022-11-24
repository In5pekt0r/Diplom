import 'dart:core';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_post.g.dart';

@JsonSerializable()
@CopyWith()
class NewsPostModel {
  NewsPostModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageLink,
    this.postLink
  });

  final int id;
  final String title;
  final String? subtitle;
  final String imageLink;
  final String? postLink;

  static List<NewsPostModel> getRandom({int n = 6, Faker? faker}) {
    final _faker = faker ?? Faker();
    return List<NewsPostModel>.generate(n, (i) =>
      NewsPostModel(
        id: i,
        title: _faker.conference.name(),
        subtitle: _faker.company.name(),
        imageLink:
          'https://loremflickr.com/260/200/all?lock=$i',
        postLink:
          'https://google.com'
      )
    );
  }

  factory NewsPostModel.fromJson(Map<String, dynamic> json) => _$NewsPostModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsPostModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NewsPostModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}

extension IterableNewsPostModel on Iterable<NewsPostModel> {
  Iterable<Map<String, dynamic>> toJson() => map((e) => e.toJson());
}
