// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationModelCWProxy {
  NotificationModel date(DateTime date);

  NotificationModel id(int id);

  NotificationModel text(String text);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationModel(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationModel call({
    DateTime? date,
    int? id,
    String? text,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationModel.copyWith.fieldName(...)`
class _$NotificationModelCWProxyImpl implements _$NotificationModelCWProxy {
  final NotificationModel _value;

  const _$NotificationModelCWProxyImpl(this._value);

  @override
  NotificationModel date(DateTime date) => this(date: date);

  @override
  NotificationModel id(int id) => this(id: id);

  @override
  NotificationModel text(String text) => this(text: text);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationModel(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationModel call({
    Object? date = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
  }) {
    return NotificationModel(
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      text: text == const $CopyWithPlaceholder()
          ? _value.text
          // ignore: cast_nullable_to_non_nullable
          : text as String,
    );
  }
}

extension $NotificationModelCopyWith on NotificationModel {
  /// Returns a callable class that can be used as follows: `instanceOfclass NotificationModel.name.copyWith(...)` or like so:`instanceOfclass NotificationModel.name.copyWith.fieldName(...)`.
  _$NotificationModelCWProxy get copyWith =>
      _$NotificationModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as int,
      date: DateTime.parse(json['date'] as String),
      text: json['text'] as String,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'text': instance.text,
    };
