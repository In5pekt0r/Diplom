// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_post.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NewsPostModelCWProxy {
  NewsPostModel id(int id);

  NewsPostModel imageLink(String imageLink);

  NewsPostModel postLink(String? postLink);

  NewsPostModel subtitle(String? subtitle);

  NewsPostModel title(String title);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewsPostModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewsPostModel(...).copyWith(id: 12, name: "My name")
  /// ````
  NewsPostModel call({
    int? id,
    String? imageLink,
    String? postLink,
    String? subtitle,
    String? title,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNewsPostModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNewsPostModel.copyWith.fieldName(...)`
class _$NewsPostModelCWProxyImpl implements _$NewsPostModelCWProxy {
  final NewsPostModel _value;

  const _$NewsPostModelCWProxyImpl(this._value);

  @override
  NewsPostModel id(int id) => this(id: id);

  @override
  NewsPostModel imageLink(String imageLink) => this(imageLink: imageLink);

  @override
  NewsPostModel postLink(String? postLink) => this(postLink: postLink);

  @override
  NewsPostModel subtitle(String? subtitle) => this(subtitle: subtitle);

  @override
  NewsPostModel title(String title) => this(title: title);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewsPostModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewsPostModel(...).copyWith(id: 12, name: "My name")
  /// ````
  NewsPostModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? imageLink = const $CopyWithPlaceholder(),
    Object? postLink = const $CopyWithPlaceholder(),
    Object? subtitle = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
  }) {
    return NewsPostModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      imageLink: imageLink == const $CopyWithPlaceholder()
          ? _value.imageLink
          // ignore: cast_nullable_to_non_nullable
          : imageLink as String,
      postLink: postLink == const $CopyWithPlaceholder()
          ? _value.postLink
          // ignore: cast_nullable_to_non_nullable
          : postLink as String?,
      subtitle: subtitle == const $CopyWithPlaceholder()
          ? _value.subtitle
          // ignore: cast_nullable_to_non_nullable
          : subtitle as String?,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
    );
  }
}

extension $NewsPostModelCopyWith on NewsPostModel {
  /// Returns a callable class that can be used as follows: `instanceOfclass NewsPostModel.name.copyWith(...)` or like so:`instanceOfclass NewsPostModel.name.copyWith.fieldName(...)`.
  _$NewsPostModelCWProxy get copyWith => _$NewsPostModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsPostModel _$NewsPostModelFromJson(Map<String, dynamic> json) =>
    NewsPostModel(
      id: json['id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      imageLink: json['imageLink'] as String,
      postLink: json['postLink'] as String?,
    );

Map<String, dynamic> _$NewsPostModelToJson(NewsPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageLink': instance.imageLink,
      'postLink': instance.postLink,
    };
