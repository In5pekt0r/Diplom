// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NewsStateCWProxy {
  NewsState news(Iterable<NewsPostModel>? news);

  NewsState status(NewsStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewsState(...).copyWith(id: 12, name: "My name")
  /// ````
  NewsState call({
    Iterable<NewsPostModel>? news,
    NewsStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNewsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNewsState.copyWith.fieldName(...)`
class _$NewsStateCWProxyImpl implements _$NewsStateCWProxy {
  final NewsState _value;

  const _$NewsStateCWProxyImpl(this._value);

  @override
  NewsState news(Iterable<NewsPostModel>? news) => this(news: news);

  @override
  NewsState status(NewsStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NewsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NewsState(...).copyWith(id: 12, name: "My name")
  /// ````
  NewsState call({
    Object? news = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return NewsState(
      news: news == const $CopyWithPlaceholder()
          ? _value.news
          // ignore: cast_nullable_to_non_nullable
          : news as Iterable<NewsPostModel>?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as NewsStatus,
    );
  }
}

extension $NewsStateCopyWith on NewsState {
  /// Returns a callable class that can be used as follows: `instanceOfclass NewsState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass NewsState extends Equatable.name.copyWith.fieldName(...)`.
  _$NewsStateCWProxy get copyWith => _$NewsStateCWProxyImpl(this);
}
