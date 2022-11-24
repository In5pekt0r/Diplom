import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/document.dart';
import '../models/poll.dart';
import '../repositories/database.dart';

part 'documents.g.dart';

class DocumentsCubit extends Cubit<DocumentsState> {
  DocumentsCubit(DatabaseRepository repository)
      : _repository = repository,
        super(const DocumentsState());

  final DatabaseRepository _repository;

  Future<void> load() async {
    if (state.status == DocumentsStatus.loading) return;
    emit(state.copyWith(status: DocumentsStatus.loading));
    try {
      final agenda = await _repository.loadDocumentsAgenda();
      final speeches = await _repository.loadDocumentsSpeeches();
      emit(state.copyWith(
          agenda: agenda, speeches: speeches,
          status: DocumentsStatus.ready
      ));
    } catch (_) {
      emit(state.copyWith(status: DocumentsStatus.error));
      rethrow;
    }
  }
}

enum DocumentsStatus { initial, loading, error, ready }

@CopyWith()
class DocumentsState extends Equatable {
  const DocumentsState({
    this.agenda = const [],
    this.speeches = const [],
    this.status = DocumentsStatus.initial,
  });

  final Iterable<DocumentModel> agenda;
  final Iterable<DocumentModel> speeches;
  final DocumentsStatus status;

  @override
  List<Object> get props =>
      <Object>[] + [status] + agenda.toList() + speeches.toList();
}
