// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendeeModel _$AttendeeModelFromJson(Map<String, dynamic> json) =>
    AttendeeModel(
      id: json['id'] as int,
      prefix: json['prefix'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      fullName: json['full_name'],
      email: json['email'] as String,
      applicationStatus: json['application_status'] as String,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$AttendeeModelToJson(AttendeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prefix': instance.prefix,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'full_name': instance.fullName,
      'application_status': instance.applicationStatus,
      'is_active': instance.isActive,
    };
