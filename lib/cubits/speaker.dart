import 'package:webrtc_conference/models/event.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/speaker.dart';
import '../repositories/database.dart';

part 'speaker.g.dart';

class SpeakerCubit extends Cubit<SpeakerState> {
  SpeakerCubit(DatabaseRepository repository)
      : _repository = repository,
        super(const SpeakerState());

  final DatabaseRepository _repository;
  int? currentSpeakerId;

  Future<void> load(SpeakerModel speaker) async {
    if (state.status == SpeakerStatus.loading && currentSpeakerId == speaker.id) return;
    emit(state.copyWith(speaker: speaker, status: SpeakerStatus.loading));
    try {
      currentSpeakerId = speaker.id;
      // print('try to load sessions ' + speaker.sessions.join(', '));
      final sessions = await _repository.loadAgendaByIds(speaker.sessions);
      // print('loaded sessions of length ' + sessions.length.toString());
      if (currentSpeakerId != speaker.id) return;
      emit(state.copyWith(sessions: sessions, status: SpeakerStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: SpeakerStatus.error));
      rethrow;
    }
  }
}

enum SpeakerStatus { initial, loading, error, ready }

@CopyWith()
class SpeakerState extends Equatable {
  const SpeakerState({
    this.speaker,
    this.sessions = const [],
    this.status = SpeakerStatus.initial,
  });

  final SpeakerModel? speaker;
  final Iterable<EventModel> sessions;
  final SpeakerStatus status;

  @override
  List<Object> get props =>
      <Object>[] + [status] + [speaker.toString()] + [sessions.map((e) => e.toString())];
}
