import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/attendee.dart';
import '../repositories/database.dart';

part 'attendees.g.dart';

class AttendeesCubit extends Cubit<AttendeesState> {
  AttendeesCubit(DatabaseRepository repository)
      : _repository = repository,
        super(const AttendeesState());

  final DatabaseRepository _repository;

  Future<void> load() async {
    if (state.status == AttendeesStatus.loading) return;
    emit(state.copyWith(status: AttendeesStatus.loading));
    try {
      final attendees = await _repository.loadAttendees();
      emit(state.copyWith(attendees: attendees, status: AttendeesStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: AttendeesStatus.error));
      rethrow;
    }
  }

  Future<void> loadWithQuery(String query) async {
    if (state.status == AttendeesStatus.loading) return;
    emit(state.copyWith(status: AttendeesStatus.loading));
    try {
      final attendees = await _repository.loadAttendeesWithQuery(query);
      emit(state.copyWith(attendees: attendees.take(1), status: AttendeesStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: AttendeesStatus.error));
      rethrow;
    }
  }
}

enum AttendeesStatus { initial, loading, error, ready }

@CopyWith()
class AttendeesState extends Equatable {
  const AttendeesState({
    this.attendees = const [],
    this.status = AttendeesStatus.initial,
  });

  final Iterable<AttendeeModel> attendees;
  final AttendeesStatus status;

  @override
  List<Object> get props =>
      <Object>[] + [status] + attendees.toList();
}
