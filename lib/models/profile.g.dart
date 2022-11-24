// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProfileModelCWProxy {
  ProfileModel avatarUrl(String? avatarUrl);

  ProfileModel bio(String? bio);

  ProfileModel country(String? country);

  ProfileModel designation(String? designation);

  ProfileModel email(String email);

  ProfileModel firstName(String firstName);

  ProfileModel id(int id);

  ProfileModel lastName(String? lastName);

  ProfileModel organization(String? organization);

  ProfileModel phone(String? phone);

  ProfileModel prefix(String? prefix);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileModel call({
    String? avatarUrl,
    String? bio,
    String? country,
    String? designation,
    String? email,
    String? firstName,
    int? id,
    String? lastName,
    String? organization,
    String? phone,
    String? prefix,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfileModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfileModel.copyWith.fieldName(...)`
class _$ProfileModelCWProxyImpl implements _$ProfileModelCWProxy {
  final ProfileModel _value;

  const _$ProfileModelCWProxyImpl(this._value);

  @override
  ProfileModel avatarUrl(String? avatarUrl) => this(avatarUrl: avatarUrl);

  @override
  ProfileModel bio(String? bio) => this(bio: bio);

  @override
  ProfileModel country(String? country) => this(country: country);

  @override
  ProfileModel designation(String? designation) =>
      this(designation: designation);

  @override
  ProfileModel email(String email) => this(email: email);

  @override
  ProfileModel firstName(String firstName) => this(firstName: firstName);

  @override
  ProfileModel id(int id) => this(id: id);

  @override
  ProfileModel lastName(String? lastName) => this(lastName: lastName);

  @override
  ProfileModel organization(String? organization) =>
      this(organization: organization);

  @override
  ProfileModel phone(String? phone) => this(phone: phone);

  @override
  ProfileModel prefix(String? prefix) => this(prefix: prefix);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileModel call({
    Object? avatarUrl = const $CopyWithPlaceholder(),
    Object? bio = const $CopyWithPlaceholder(),
    Object? country = const $CopyWithPlaceholder(),
    Object? designation = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? firstName = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? organization = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? prefix = const $CopyWithPlaceholder(),
  }) {
    return ProfileModel(
      avatarUrl: avatarUrl == const $CopyWithPlaceholder()
          ? _value.avatarUrl
          // ignore: cast_nullable_to_non_nullable
          : avatarUrl as String?,
      bio: bio == const $CopyWithPlaceholder()
          ? _value.bio
          // ignore: cast_nullable_to_non_nullable
          : bio as String?,
      country: country == const $CopyWithPlaceholder()
          ? _value.country
          // ignore: cast_nullable_to_non_nullable
          : country as String?,
      designation: designation == const $CopyWithPlaceholder()
          ? _value.designation
          // ignore: cast_nullable_to_non_nullable
          : designation as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      firstName: firstName == const $CopyWithPlaceholder()
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      lastName: lastName == const $CopyWithPlaceholder()
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String?,
      organization: organization == const $CopyWithPlaceholder()
          ? _value.organization
          // ignore: cast_nullable_to_non_nullable
          : organization as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      prefix: prefix == const $CopyWithPlaceholder()
          ? _value.prefix
          // ignore: cast_nullable_to_non_nullable
          : prefix as String?,
    );
  }
}

extension $ProfileModelCopyWith on ProfileModel {
  /// Returns a callable class that can be used as follows: `instanceOfclass ProfileModel.name.copyWith(...)` or like so:`instanceOfclass ProfileModel.name.copyWith.fieldName(...)`.
  _$ProfileModelCWProxy get copyWith => _$ProfileModelCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      prefix: json['prefix'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      designation: json['designation'] as String?,
      organization: json['organization'] as String?,
      country: json['country'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    )..personalAgenda =
        (json['personal_agenda'] as List<dynamic>).map((e) => e as int);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'prefix': instance.prefix,
      'email': instance.email,
      'phone': instance.phone,
      'designation': instance.designation,
      'organization': instance.organization,
      'country': instance.country,
      'bio': instance.bio,
      'avatarUrl': instance.avatarUrl,
      'personal_agenda': instance.personalAgenda.toList(),
    };
