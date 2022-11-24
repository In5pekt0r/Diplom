// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SpeakerModelCWProxy {
  SpeakerModel avatarUrl(String? avatarUrl);

  SpeakerModel bio(String bio);

  SpeakerModel email(String email);

  SpeakerModel firstName(String firstName);

  SpeakerModel fullName(dynamic fullName);

  SpeakerModel id(int id);

  SpeakerModel job(String job);

  SpeakerModel lastName(String lastName);

  SpeakerModel prefix(String prefix);

  SpeakerModel sessions(Iterable<int> sessions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SpeakerModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SpeakerModel(...).copyWith(id: 12, name: "My name")
  /// ````
  SpeakerModel call({
    String? avatarUrl,
    String? bio,
    String? email,
    String? firstName,
    dynamic? fullName,
    int? id,
    String? job,
    String? lastName,
    String? prefix,
    Iterable<int>? sessions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSpeakerModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSpeakerModel.copyWith.fieldName(...)`
class _$SpeakerModelCWProxyImpl implements _$SpeakerModelCWProxy {
  final SpeakerModel _value;

  const _$SpeakerModelCWProxyImpl(this._value);

  @override
  SpeakerModel avatarUrl(String? avatarUrl) => this(avatarUrl: avatarUrl);

  @override
  SpeakerModel bio(String bio) => this(bio: bio);

  @override
  SpeakerModel email(String email) => this(email: email);

  @override
  SpeakerModel firstName(String firstName) => this(firstName: firstName);

  @override
  SpeakerModel fullName(dynamic fullName) => this(fullName: fullName);

  @override
  SpeakerModel id(int id) => this(id: id);

  @override
  SpeakerModel job(String job) => this(job: job);

  @override
  SpeakerModel lastName(String lastName) => this(lastName: lastName);

  @override
  SpeakerModel prefix(String prefix) => this(prefix: prefix);

  @override
  SpeakerModel sessions(Iterable<int> sessions) => this(sessions: sessions);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SpeakerModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SpeakerModel(...).copyWith(id: 12, name: "My name")
  /// ````
  SpeakerModel call({
    Object? avatarUrl = const $CopyWithPlaceholder(),
    Object? bio = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? firstName = const $CopyWithPlaceholder(),
    Object? fullName = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? job = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? prefix = const $CopyWithPlaceholder(),
    Object? sessions = const $CopyWithPlaceholder(),
  }) {
    return SpeakerModel(
      avatarUrl: avatarUrl == const $CopyWithPlaceholder()
          ? _value.avatarUrl
          // ignore: cast_nullable_to_non_nullable
          : avatarUrl as String?,
      bio: bio == const $CopyWithPlaceholder()
          ? _value.bio
          // ignore: cast_nullable_to_non_nullable
          : bio as String,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      firstName: firstName == const $CopyWithPlaceholder()
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String,
      fullName: fullName == const $CopyWithPlaceholder()
          ? _value.fullName
          // ignore: cast_nullable_to_non_nullable
          : fullName as dynamic,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      job: job == const $CopyWithPlaceholder()
          ? _value.job
          // ignore: cast_nullable_to_non_nullable
          : job as String,
      lastName: lastName == const $CopyWithPlaceholder()
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String,
      prefix: prefix == const $CopyWithPlaceholder()
          ? _value.prefix
          // ignore: cast_nullable_to_non_nullable
          : prefix as String,
      sessions: sessions == const $CopyWithPlaceholder()
          ? _value.sessions
          // ignore: cast_nullable_to_non_nullable
          : sessions as Iterable<int>,
    );
  }
}

extension $SpeakerModelCopyWith on SpeakerModel {
  /// Returns a callable class that can be used as follows: `instanceOfclass SpeakerModel.name.copyWith(...)` or like so:`instanceOfclass SpeakerModel.name.copyWith.fieldName(...)`.
  _$SpeakerModelCWProxy get copyWith => _$SpeakerModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeakerModel _$SpeakerModelFromJson(Map<String, dynamic> json) => SpeakerModel(
      id: json['id'] as int,
      prefix: json['prefix'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      fullName: json['full_name'],
      avatarUrl: json['avatar_url'] as String?,
      email: json['email'] as String,
      bio: json['bio'] as String,
      job: json['job'] as String,
      sessions: (json['sessions'] as List<dynamic>?)?.map((e) => e as int) ??
          const [],
    );

Map<String, dynamic> _$SpeakerModelToJson(SpeakerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prefix': instance.prefix,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'full_name': instance.fullName,
      'avatar_url': instance.avatarUrl,
      'email': instance.email,
      'bio': instance.bio,
      'job': instance.job,
      'sessions': instance.sessions.toList(),
    };
