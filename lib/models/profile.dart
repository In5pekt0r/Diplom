
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'profile.g.dart';

@CopyWith()
@JsonSerializable()
class ProfileModel {
  ProfileModel({
    required this.id,
    required this.firstName,
    this.lastName,
    this.prefix,
    required this.email,
    this.phone,
    this.designation,
    this.organization,
    this.country,
    this.bio,
    this.avatarUrl,
  });

  final int id;
  final String firstName;
  final String? lastName;
  final String? prefix;
  final String email;
  final String? phone;
  final String? designation;
  final String? organization;
  final String? country;
  final String? bio;
  final String? avatarUrl;

  @JsonKey(name: 'personal_agenda')
  Iterable<int> personalAgenda = [];

  static List<ProfileModel> getRandom({int n = 1, Faker? faker}) {
    final _faker = faker ?? Faker();
    return List<ProfileModel>.generate(n, (i) =>
        ProfileModel(
          id: i,
          firstName: _faker.person.firstName(),
          lastName: _faker.person.lastName(),
          prefix: _faker.person.prefix(),
          email: _faker.internet.email(),
          phone: _faker.phoneNumber.toString(),
          designation: _faker.job.title(),
          organization: _faker.company.name(),
          country: _faker.address.country(),
          bio: _faker.lorem.sentences(20).join(' '),
          avatarUrl:
            'https://loremflickr.com/375/230/human,portrait/all?lock=$i'
        )
    );
  }

  List<Object?> get props => [
    firstName, lastName, prefix, email, phone, designation, organization, country, bio, personalAgenda
  ];

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          prefix == other.prefix &&
          email == other.email &&
          phone == other.phone &&
          designation == other.designation &&
          organization == other.organization &&
          country == other.country &&
          bio == other.bio &&
          avatarUrl == other.avatarUrl &&
          personalAgenda == other.personalAgenda;

  @override
  int get hashCode =>
      id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      prefix.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      designation.hashCode ^
      organization.hashCode ^
      country.hashCode ^
      bio.hashCode ^
      avatarUrl.hashCode ^
      personalAgenda.hashCode;
}
