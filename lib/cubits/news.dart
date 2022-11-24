import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:webrtc_conference/models/news_post.dart';
import 'package:webrtc_conference/models/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/repositories/database.dart';

part 'news.g.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(DatabaseRepository repository)
      : _repository = repository,
        super(NewsState());

  final DatabaseRepository _repository;

  Future<void> load() async {
    if (state.status == NewsStatus.loading) return;
    emit(state.copyWith(status: NewsStatus.loading));
    try {
      final news = await _repository.loadNews();
      emit(state.copyWith(news: news, status: NewsStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: NewsStatus.error));
      rethrow;
    }
  }
}

enum NewsStatus { initial, loading, error, ready }

@CopyWith()
class NewsState extends Equatable {
  NewsState({
    this.news,
    this.status = NewsStatus.initial,
  });

  final Iterable<NewsPostModel>? news;
  final NewsStatus status;

  @override
  List<Object?> get props => [
    news,
    status,
  ];
}
