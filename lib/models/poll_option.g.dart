// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_option.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PollOptionModelCWProxy {
  PollOptionModel count(int count);

  PollOptionModel id(int id);

  PollOptionModel isChosen(bool isChosen);

  PollOptionModel text(String text);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PollOptionModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PollOptionModel(...).copyWith(id: 12, name: "My name")
  /// ````
  PollOptionModel call({
    int? count,
    int? id,
    bool? isChosen,
    String? text,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPollOptionModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPollOptionModel.copyWith.fieldName(...)`
class _$PollOptionModelCWProxyImpl implements _$PollOptionModelCWProxy {
  final PollOptionModel _value;

  const _$PollOptionModelCWProxyImpl(this._value);

  @override
  PollOptionModel count(int count) => this(count: count);

  @override
  PollOptionModel id(int id) => this(id: id);

  @override
  PollOptionModel isChosen(bool isChosen) => this(isChosen: isChosen);

  @override
  PollOptionModel text(String text) => this(text: text);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PollOptionModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PollOptionModel(...).copyWith(id: 12, name: "My name")
  /// ````
  PollOptionModel call({
    Object? count = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isChosen = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
  }) {
    return PollOptionModel(
      count: count == const $CopyWithPlaceholder()
          ? _value.count
          // ignore: cast_nullable_to_non_nullable
          : count as int,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      isChosen: isChosen == const $CopyWithPlaceholder()
          ? _value.isChosen
          // ignore: cast_nullable_to_non_nullable
          : isChosen as bool,
      text: text == const $CopyWithPlaceholder()
          ? _value.text
          // ignore: cast_nullable_to_non_nullable
          : text as String,
    );
  }
}

extension $PollOptionModelCopyWith on PollOptionModel {
  /// Returns a callable class that can be used as follows: `instanceOfclass PollOptionModel.name.copyWith(...)` or like so:`instanceOfclass PollOptionModel.name.copyWith.fieldName(...)`.
  _$PollOptionModelCWProxy get copyWith => _$PollOptionModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollOptionModel _$PollOptionModelFromJson(Map<String, dynamic> json) =>
    PollOptionModel(
      id: json['id'] as int,
      text: json['text'] as String,
      count: json['count'] as int,
      isChosen: json['is_chosen'] as bool,
    );

Map<String, dynamic> _$PollOptionModelToJson(PollOptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'count': instance.count,
      'is_chosen': instance.isChosen,
    };
