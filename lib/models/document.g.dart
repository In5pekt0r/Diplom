// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentModelCWProxy {
  DocumentModel id(int id);

  DocumentModel link(String link);

  DocumentModel name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentModel(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentModel call({
    int? id,
    String? link,
    String? name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentModel.copyWith.fieldName(...)`
class _$DocumentModelCWProxyImpl implements _$DocumentModelCWProxy {
  final DocumentModel _value;

  const _$DocumentModelCWProxyImpl(this._value);

  @override
  DocumentModel id(int id) => this(id: id);

  @override
  DocumentModel link(String link) => this(link: link);

  @override
  DocumentModel name(String name) => this(name: name);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentModel(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? link = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return DocumentModel(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      link: link == const $CopyWithPlaceholder()
          ? _value.link
          // ignore: cast_nullable_to_non_nullable
          : link as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $DocumentModelCopyWith on DocumentModel {
  /// Returns a callable class that can be used as follows: `instanceOfclass DocumentModel.name.copyWith(...)` or like so:`instanceOfclass DocumentModel.name.copyWith.fieldName(...)`.
  _$DocumentModelCWProxy get copyWith => _$DocumentModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentModel _$DocumentModelFromJson(Map<String, dynamic> json) =>
    DocumentModel(
      id: json['id'] as int,
      name: json['name'] as String,
      link: json['link'] as String,
    );

Map<String, dynamic> _$DocumentModelToJson(DocumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'link': instance.link,
    };
