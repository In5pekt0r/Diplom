import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:faker/faker.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'speaker.g.dart';

/// Json representation:
/// [
///   {
///     "id": 1,
///     "prefix": "Mr",
///     "first_name": "hui",
///     "last_name": "xiano",
///     "full_name": "hui xiano",
///     "avatar_url": "string", // хуйня, которая пока не работает
///     "email": "hui_xiano@kek.ru"
///   }
/// ]
///
@JsonSerializable()
@CopyWith()
class SpeakerModel {
  SpeakerModel({
    required this.id,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    fullName,
    this.avatarUrl,
    required this.email,
    required this.bio,
    required this.job,
    this.sessions = const [],
  }) : fullName = fullName ?? '$prefix $firstName $lastName';

  final int id;
  final String prefix;

  @JsonKey(name: "first_name")
  final String firstName;

  @JsonKey(name: "last_name")
  final String lastName;

  @JsonKey(name: "full_name")
  final String fullName;

  @JsonKey(name: "avatar_url")
  final String? avatarUrl;
  final String email;
  final String bio;
  final String job;

  Iterable<int> sessions;

  static List<SpeakerModel> getRandom({int n = 100, Faker? faker}) {
    final _faker = faker ?? Faker();
    return List<SpeakerModel>.generate(n, (i) => SpeakerModel(
        id: i,
        prefix: _faker.person.prefix(),
        firstName: _faker.person.firstName(),
        lastName: _faker.person.lastName(),
        avatarUrl:
          'https://loremflickr.com/375/230/human,portrait/all?lock=$i'
          // 'https://picsum.photos/id/$i/375/230'
        ,
        email: _faker.internet.email(),
        bio: _faker.lorem.sentences(30).join(' '),
        job: _faker.job.title()
      )
    );
  }

  factory SpeakerModel.fromJson(Map<String, dynamic> json) => _$SpeakerModelFromJson(json);
  Map<String, dynamic> toJson() => _$SpeakerModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeakerModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

extension IterableSpeakerModel on Iterable<SpeakerModel> {
  Iterable<Map<String, dynamic>> toJson() =>
      map((e) => e.toJson());
}
