import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/search.dart';
import '../repositories/database.dart';

part 'search.g.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(DatabaseRepository repository)
      : _repository = repository,
        super(const SearchState());

  final DatabaseRepository _repository;

  Future<void> loadWithQuery(String value) async {
    if (state.status == SearchStatus.loading) return;
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final searchModel = await _repository.searchAll(value);
      emit(state.copyWith(searchModel: searchModel, status: SearchStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: SearchStatus.error));
      rethrow;
    }
  }

  Future<void> clear() async {
    if (state.status == SearchStatus.loading) return;
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final searchModel = SearchModel();
      emit(state.copyWith(searchModel: searchModel, status: SearchStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: SearchStatus.error));
      rethrow;
    }
  }
}

enum SearchStatus { initial, loading, error, ready }

@CopyWith()
class SearchState extends Equatable {
  const SearchState({
    this.searchModel,
    this.status = SearchStatus.initial,
  });

  final SearchModel? searchModel;
  final SearchStatus status;

  @override
  List<Object> get props =>
      <Object>[] + [status] + [searchModel.toString()];
}
