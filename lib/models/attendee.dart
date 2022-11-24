import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendee.g.dart';

/// Json representation:
/// [
///     {
///         "prefix": "Mr",
///         "first_name": "string",
///         "last_name": "string",
///         "email": "email@mail.net",
///         "application_status": "string",
///         "is_active": true
///     }
/// ]
///
@JsonSerializable()
class AttendeeModel {
  AttendeeModel({
    required this.id,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    fullName,
    required this.email,
    required this.applicationStatus,
    required this.isActive,
  }) : fullName = fullName ?? '$prefix $firstName $lastName';

  final int id;
  final String prefix;

  @JsonKey(name: "first_name")
  final String firstName;

  @JsonKey(name: "last_name")
  final String lastName;
  final String email;

  @JsonKey(name: "full_name")
  final String fullName;

  @JsonKey(name: "application_status")
  final String applicationStatus;

  @JsonKey(name: "is_active")
  final bool isActive;

  static List<AttendeeModel> getRandom({int n = 100, Faker? faker}) {
    final _faker = faker ?? Faker();
    return List<AttendeeModel>.generate(n, (i) =>
      AttendeeModel(
        id: i,
        prefix: _faker.person.prefix(),
        firstName: _faker.person.firstName(),
        lastName: _faker.person.lastName(),
        email: _faker.internet.email(),
        applicationStatus: "accepted",
        isActive: true,
      )
    );
  }

  factory AttendeeModel.fromJson(Map<String, dynamic> json) => _$AttendeeModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttendeeModelToJson(this);
}

extension IterableAttendeeModel on Iterable<AttendeeModel> {
  Iterable<Map<String, dynamic>> toJson() =>
      map((e) => e.toJson());
}
