import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:webrtc_conference/models/poll_option.dart';

part 'poll.g.dart';

/// Json representation:
// {
//   "name": "string",
//   "text": "string",
//   "voters_count": 31337,
//   "multi_choice": true, // можно хуй забить
//   "options": [
//     {
//     "id": 1,
//     "text": "string",
//     "count": 0,
//     "is_chosen": true
//     },
//     {
//     "id": 2,
//     "text": "string",
//     "count": 31337,
//     "is_chosen": false
//     }
//   ]
// }
///
@JsonSerializable(explicitToJson: true)
class PollModel {
  PollModel({
    required this.id,
    required this.name,
    required this.text,
    required this.votersCount,
    required this.isMultiChoice,
    required this.options,
  }) :  showingResults = options.any((element) => element.isChosen);

  final int id;
  final String name;
  final String text;

  @JsonKey(name: "voters_count")
  int votersCount;

  @JsonKey(name: "multi_choice")
  final bool isMultiChoice;

  @JsonKey(ignore: true)
  bool showingResults;

  Iterable<PollOptionModel> options;

  static List<PollModel> getRandom({int n = 10, Faker? faker}) {
    Faker _faker = faker ?? Faker();
    return List<PollModel>.generate(n, (i) => PollModel(
            id: i,
            name: _faker.lorem.sentence(),
            text: _faker.food.restaurant(),
            votersCount: 10000,
            isMultiChoice: i % 3 == 0,
            options: PollOptionModel.getRandom(
                n: _faker.randomGenerator.integer(5, min: 2),
                isMultiChoice: _faker.randomGenerator.boolean(),
                withAnswers: _faker.randomGenerator.boolean(),
                votersCount: 10000,
                faker: _faker
            ),
          )
    );
  }

  factory PollModel.fromJson(Map<String, dynamic> json) => _$PollModelFromJson(json);
  Map<String, dynamic> toJson() => _$PollModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PollModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          text == other.text &&
          votersCount == other.votersCount &&
          isMultiChoice == other.isMultiChoice &&
          options == other.options;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      text.hashCode ^
      votersCount.hashCode ^
      isMultiChoice.hashCode ^
      options.hashCode;
}

extension IterablePollModel on Iterable<PollModel> {
  Iterable<Map<String, dynamic>> toJson() =>
      map((e) => e.toJson());
}
