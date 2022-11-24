import 'package:webrtc_conference/models/event.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/database.dart';

part 'agenda.g.dart';

class AgendaCubit extends Cubit<AgendaState> {
  AgendaCubit(DatabaseRepository repository)
      : _repository = repository,
        super(const AgendaState());

  final DatabaseRepository _repository;

  Future<void> load() async {
    if (state.status == AgendaStatus.loading) return;
    emit(state.copyWith(status: AgendaStatus.loading));
    try {
      final agenda = await _repository.loadAgenda();
      emit(state.copyWith(agenda: agenda, status: AgendaStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: AgendaStatus.error));
      rethrow;
    }
  }
}

enum AgendaStatus { initial, loading, error, ready }

@CopyWith()
class AgendaState extends Equatable {
  const AgendaState({
    this.agenda = const {},
    this.status = AgendaStatus.initial,
  });

  final Iterable<EventModel> agenda;
  final AgendaStatus status;

  @override
  List<Object> get props =>
    <Object>[] + [status] + agenda.toList();
}
