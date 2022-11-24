import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/speaker.dart';
import '../repositories/database.dart';

part 'speakers.g.dart';

class SpeakersCubit extends Cubit<SpeakersState> {
  SpeakersCubit(DatabaseRepository repository)
      : _repository = repository,
        super(const SpeakersState());

  final DatabaseRepository _repository;

  Future<void> load() async {
    if (state.status == SpeakersStatus.loading) return;
    emit(state.copyWith(status: SpeakersStatus.loading));
    try {
      final speakers = await _repository.loadSpeakers();
      emit(state.copyWith(speakers: speakers, status: SpeakersStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: SpeakersStatus.error));
      rethrow;
    }
  }

  Future<void> loadWithQuery(String query) async {
    if (state.status == SpeakersStatus.loading) return;
    emit(state.copyWith(status: SpeakersStatus.loading));
    try {
      final speakers = await _repository.loadSpeakersWithQuery(query);
      emit(state.copyWith(speakers: speakers.take(1), status: SpeakersStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: SpeakersStatus.error));
      rethrow;
    }
  }
}

enum SpeakersStatus { initial, loading, error, ready }

@CopyWith()
class SpeakersState extends Equatable {
  const SpeakersState({
    this.speakers = const [],
    this.status = SpeakersStatus.initial,
  });

  final Iterable<SpeakerModel> speakers;
  final SpeakersStatus status;

  @override
  List<Object> get props =>
      <Object>[] + [status] + speakers.toList();
}
