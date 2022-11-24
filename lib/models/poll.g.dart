// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollModel _$PollModelFromJson(Map<String, dynamic> json) => PollModel(
      id: json['id'] as int,
      name: json['name'] as String,
      text: json['text'] as String,
      votersCount: json['voters_count'] as int,
      isMultiChoice: json['multi_choice'] as bool,
      options: (json['options'] as List<dynamic>)
          .map((e) => PollOptionModel.fromJson(e as Map<String, dynamic>)),
    );

Map<String, dynamic> _$PollModelToJson(PollModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'text': instance.text,
      'voters_count': instance.votersCount,
      'multi_choice': instance.isMultiChoice,
      'options': instance.options.map((e) => e.toJson()).toList(),
    };
