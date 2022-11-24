import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:faker/faker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'poll_option.g.dart';

/// Json representation:
// {
//   "id": 1,
//   "text": "string",
//   "count": 0,
//   "is_chosen": true
// },
///
///
@JsonSerializable()
@CopyWith()
class PollOptionModel {
  PollOptionModel({
    required this.id,
    required this.text,
    required this.count,
    required this.isChosen,
  });

  final int id;
  final String text;
  int count;

  @JsonKey(name: "is_chosen")
  bool isChosen;

  static List<PollOptionModel> getRandom({
    int n = 100,
    required bool isMultiChoice,
    required int votersCount,
    required bool withAnswers,
    required Faker faker
  }) {
    var chosenAnswers = withAnswers
      ? isMultiChoice
        ? List<int>.generate(n ~/ 2, (index) => index * 2)
        : [0]
      : [];
    var counts = [];
    var leftVotersCount = votersCount;
    while (counts.length + 1 != n) {
      final newCount = faker.randomGenerator.integer(leftVotersCount + 1);
      counts.add(newCount);
      leftVotersCount -= newCount;
    }
    counts.add(leftVotersCount);
    return List<PollOptionModel>.generate(n, (i) => PollOptionModel(
        id: i,
        text: faker.food.dish(),
        count: counts[i],
        isChosen: chosenAnswers.contains(i),
      )
    );
  }

  factory PollOptionModel.fromJson(Map<String, dynamic> json) => _$PollOptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$PollOptionModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PollOptionModel &&
          id == other.id;

  @override
  int get hashCode =>
      id.hashCode;
}
