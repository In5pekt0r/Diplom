import 'package:webrtc_conference/models/event.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/database.dart';

part 'personal_agenda.g.dart';

class PersonalAgendaCubit extends Cubit<PersonalAgendaState> {
  PersonalAgendaCubit(DatabaseRepository repository)
      : _repository = repository,
        super(const PersonalAgendaState());

  final DatabaseRepository _repository;

  Future<void> load(Iterable<int> eventIds) async {
    if (state.status == PersonalAgendaStatus.loading) return;
    emit(state.copyWith(status: PersonalAgendaStatus.loading));
    try {
      final agenda = await _repository.loadAgendaByIds(eventIds);
      emit(state.copyWith(agenda: agenda, status: PersonalAgendaStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: PersonalAgendaStatus.error));
      rethrow;
    }
  }
}

enum PersonalAgendaStatus { initial, loading, error, ready }

@CopyWith()
class PersonalAgendaState extends Equatable {
  const PersonalAgendaState({
    this.agenda = const [],
    this.status = PersonalAgendaStatus.initial,
  });

  final Iterable<EventModel> agenda;
  final PersonalAgendaStatus status;

  @override
  List<Object> get props =>
      <Object>[] + [status] + agenda.toList();
}
