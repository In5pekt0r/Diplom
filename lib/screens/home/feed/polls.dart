import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/models/poll_option.dart';
import 'package:collection/collection.dart';
import 'package:webrtc_conference/widgets/blue_rounded_button.dart';

import '../../../common/helpers.dart';
import '../../../common/route.dart';

import '../../../cubits/polls.dart';
import '../../../models/poll.dart';
class PollsScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Polls',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PollsList(),
    );
  }
}

class PollsList extends StatefulWidget {
  PollsList({
    this.onlyOne = false,
    this.singleAndNonScrollable = false,
    this.horizontalPadding
  });
  final bool onlyOne;
  final bool singleAndNonScrollable;
  final double? horizontalPadding;

  @override
  State<StatefulWidget> createState() => _PollsListState(
    onlyOne: onlyOne,
    singleAndNonScrollable: singleAndNonScrollable,
    horizontalPadding: horizontalPadding,
  );
}

class _PollsListState extends State<PollsList> {
  _PollsListState({
    required this.onlyOne,
    this.singleAndNonScrollable = false,
    this.horizontalPadding
  });
  final bool onlyOne;
  final bool singleAndNonScrollable;
  final double? horizontalPadding;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    load(() => context.read<PollsCubit>().load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PollsCubit, PollsState>(
      builder: (BuildContext context, PollsState state) {
        final cases = {
          PollsStatus.initial: () => Container(),
          PollsStatus.loading: () =>
              const Center(child: CircularProgressIndicator()),
          PollsStatus.error: () {
            return Center(
                child: FloatingActionButton(
                  onPressed: () {
                    BotToast.cleanAll();
                    _load();
                  },
                  child: const Icon(Icons.replay),
                )
            );
          },
          PollsStatus.ready: () =>
              PollsListImpl(
                polls: state.polls,
                singleAndNonScrollable: singleAndNonScrollable,
                horizontalPadding: horizontalPadding,
                onlyOne: onlyOne,
              ),
        };
        assert(cases.length == PollsStatus.values.length);
        return cases[state.status]!();
      },
    );
  }
}

class PollsListImpl extends StatelessWidget {
  PollsListImpl({
    required this.polls,
    this.onlyOne = false,
    this.singleAndNonScrollable = false,
    double? horizontalPadding
  }) : horizontalPadding = horizontalPadding ?? 16;
  final Iterable<PollModel> polls;
  final bool onlyOne;
  final bool singleAndNonScrollable;
  final double horizontalPadding;

  Widget pollView(PollModel pollModel, void Function(Iterable<int>? answer) onSubmit) {
    if (pollModel.isMultiChoice) {
      return PollMultipleChoice(poll: pollModel, key: Key(pollModel.id.toString()), onSubmit: onSubmit);
    }
    return PollSingleChoice(poll: pollModel, key: Key(pollModel.id.toString()), onSubmit: onSubmit);
  }

  void onSubmit(BuildContext context, PollModel poll, Iterable<int>? answer) {
    load(() => context.read<PollsCubit>().votePoll(poll.id, answer));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 4, horizontalPadding, singleAndNonScrollable ? 16 : 140),
      itemCount: onlyOne ? min(polls.length, 1) : polls.length,
      shrinkWrap: singleAndNonScrollable,
      physics: singleAndNonScrollable ? const NeverScrollableScrollPhysics() : null,
      separatorBuilder: (context, index) =>
          const Divider(
            height: 12,
            color: Colors.transparent,
          ),
      itemBuilder: (context, index) {
        final poll = polls.elementAt(index);
        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    poll.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                poll.showingResults
                    ? PollVoted(poll: poll)
                    : pollView(
                      poll,
                      (answer) { onSubmit(context, poll, answer); }
                    )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PollSingleChoice extends StatefulWidget {
  const PollSingleChoice({
    required this.poll,
    required this.onSubmit,
    Key? key
  }) : super(key: key);
  final PollModel poll;
  final void Function(Iterable<int>? answer) onSubmit;

  @override
  State<PollSingleChoice> createState() =>
      _PollSingleChoiceState(
        poll: poll,
        onSubmit: onSubmit
      );
}

class _PollSingleChoiceState extends State<PollSingleChoice> {
  _PollSingleChoiceState({
    required this.poll,
    required this.onSubmit,
  })
    : _answer = poll.options.firstWhereOrNull((element) => element.isChosen);

  final PollModel poll;
  final void Function(Iterable<int>? answer) onSubmit;

  PollOptionModel? _answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...poll.options.map((option) =>
            RadioListTile<PollOptionModel>(
              title: Text(option.text),
              value: option,
              groupValue: _answer,
              onChanged: (value) {
                setState(() {
                  _answer = option;
                });
              },
            )
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...(_answer != null ? [
              BlueRoundedButton(
                  text: 'Clear',
                  dense: true,
                  onPress: () {
                    setState(() {
                      _answer = null;
                    });
                  }
              ),
              const SizedBox(width: 16),
            ] : []),
            BlueRoundedButton(
              text: 'Submit',
              dense: true,
              onPress: _answer != null ? () { onSubmit([_answer!.id]); } : null,
            )
          ],
        )
      ],
    );
  }
}



class PollMultipleChoice extends StatefulWidget {
  const PollMultipleChoice({
    required this.poll,
    required this.onSubmit,
    Key? key
  }) : super(key: key);
  final PollModel poll;
  final void Function(Iterable<int>? answer) onSubmit;

  @override
  State<PollMultipleChoice> createState() =>
      _PollMultipleChoiceState(
        poll: poll,
        onSubmit: onSubmit
      );
}

class _PollMultipleChoiceState extends State<PollMultipleChoice> {
  _PollMultipleChoiceState({
    required this.poll,
    required this.onSubmit,
  });

  final PollModel poll;
  final void Function(Iterable<int>? answer) onSubmit;

  void updateChoice(PollOptionModel option, bool? newValue) {
    if (newValue == null) return;
    setState(() {
      poll.options = poll.options.map((e) =>
        e.id != option.id ? e : e.copyWith(isChosen: newValue)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...poll.options.map((option) =>
          CheckboxListTile(
            title: Text(option.text),
            value: option.isChosen,
            onChanged: (bool? value) {
              setState(() {
                updateChoice(option, value);
              });
            },
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...(poll.options.any((e) => e.isChosen) ? [
              BlueRoundedButton(
                  text: 'Clear',
                  dense: true,
                  onPress: () {
                    setState(() {
                      poll.options = poll.options.map((e) => e.copyWith(isChosen: false));
                    });
                  }
              ),
              const SizedBox(width: 16),
            ] : []),
            BlueRoundedButton(
              text: 'Submit',
              dense: true,
              onPress: poll.options.any((e) => e.isChosen) ? () {
                onSubmit(poll.options.where((e) => e.isChosen).map((e) => e.id));
              } : null,
            )
          ],
        ),
      ],
    );
  }
}

class PollVoted extends StatelessWidget {
  PollVoted({required this.poll});
  final PollModel poll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...poll.options.map((option) =>
          ListTile(
            dense: true,
            horizontalTitleGap: -40,
            leading: Transform.translate(
              offset: const Offset(0, 6),
              child: option.isChosen
                  ? poll.isMultiChoice
                    ? const Icon(Icons.check_box_outlined)
                    : const Icon(Icons.check_circle_outlined)
                  : null,
            ),
            title: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child:
                  Text(
                    option.text,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: LinearProgressIndicator(
                    value: option.count / poll.votersCount,
                    semanticsLabel: option.text,
                    backgroundColor: Colors.black12,
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                  ),
                )
              ],
            ),
          )
        ),
      ],
    );
  }
}
