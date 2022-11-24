import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/poll.dart';
import '../repositories/database.dart';

part 'polls.g.dart';

class PollsCubit extends Cubit<PollsState> {
  PollsCubit(DatabaseRepository repository)
      : _repository = repository,
        super(const PollsState());

  final DatabaseRepository _repository;

  Future<void> load() async {
    if (state.status == PollsStatus.loading) return;
    emit(state.copyWith(status: PollsStatus.loading));
    try {
      final polls = await _repository.loadPolls();
      emit(state.copyWith(polls: polls, status: PollsStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: PollsStatus.error));
      rethrow;
    }
  }

  Future<void> loadRandomOne() async {
    if (state.status == PollsStatus.loading) return;
    emit(state.copyWith(status: PollsStatus.loading));
    try {
      final poll = await _repository.loadRandomPoll();
      emit(state.copyWith(polls: [poll], status: PollsStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: PollsStatus.error));
      rethrow;
    }
  }

  Future<void> votePoll(int pollId, Iterable<int>? answer) async {
    if (answer == null || answer.isEmpty || state.status == PollsStatus.loading) return;
    emit(state.copyWith(status: PollsStatus.loading));
    try {
      final polls = await _repository.votePoll(pollId, answer);
      emit(state.copyWith(polls: polls, status: PollsStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: PollsStatus.error));
      rethrow;
    }
  }
}

enum PollsStatus { initial, loading, error, ready }

@CopyWith()
class PollsState extends Equatable {
  const PollsState({
    this.polls = const [],
    this.status = PollsStatus.initial,
  });

  final Iterable<PollModel> polls;
  final PollsStatus status;

  @override
  List<Object> get props =>
      <Object>[] + [status] + polls.toList();
}
