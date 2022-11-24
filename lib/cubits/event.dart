import 'package:webrtc_conference/models/event.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/speaker.dart';
import '../repositories/database.dart';

part 'event.g.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit(DatabaseRepository repository)
      : _repository = repository,
        super(const EventState());

  final DatabaseRepository _repository;
  int? currentEventId;

  Future<void> load(EventModel event) async {
    if (state.status == EventStatus.loading && currentEventId == event.id) return;
    emit(state.copyWith(event: event, status: EventStatus.loading));
    try {
      currentEventId = event.id;
      final speakers = await _repository.loadSpeakersByIds(event.speakers);
      if (currentEventId != event.id) return;
      emit(state.copyWith(speakers: speakers, status: EventStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: EventStatus.error));
      rethrow;
    }
  }

  Future<void> addEventToPersonalAgenda(EventModel event) async {
    if (state.status == EventStatus.loading && currentEventId == event.id) return;
    emit(state.copyWith(event: event, status: EventStatus.loading));
    try {
      currentEventId = event.id;
      await _repository.addEventToPersonalAgenda(event.id);
      if (currentEventId != event.id) return;
      emit(state.copyWith(status: EventStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: EventStatus.error));
      rethrow;
    }
  }

  Future<void> removeEventFromPersonalAgenda(EventModel event) async {
    if (state.status == EventStatus.loading && currentEventId == event.id) return;
    emit(state.copyWith(event: event, status: EventStatus.loading));
    try {
      currentEventId = event.id;
      await _repository.removeEventFromPersonalAgenda(event.id);
      if (currentEventId != event.id) return;
      emit(state.copyWith(status: EventStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: EventStatus.error));
      rethrow;
    }
  }
}

enum EventStatus { initial, loading, error, ready }

@CopyWith()
class EventState extends Equatable {
  const EventState({
    this.event,
    this.speakers = const [],
    this.status = EventStatus.initial,
  });

  final EventModel? event;
  final Iterable<SpeakerModel> speakers;
  final EventStatus status;

  @override
  List<Object> get props =>
      <Object>[] + [status] + [event.toString()] + [speakers.map((e) => e.toString())];
}
