// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SearchStateCWProxy {
  SearchState searchModel(SearchModel? searchModel);

  SearchState status(SearchStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchState(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchState call({
    SearchModel? searchModel,
    SearchStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSearchState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSearchState.copyWith.fieldName(...)`
class _$SearchStateCWProxyImpl implements _$SearchStateCWProxy {
  final SearchState _value;

  const _$SearchStateCWProxyImpl(this._value);

  @override
  SearchState searchModel(SearchModel? searchModel) =>
      this(searchModel: searchModel);

  @override
  SearchState status(SearchStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchState(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchState call({
    Object? searchModel = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return SearchState(
      searchModel: searchModel == const $CopyWithPlaceholder()
          ? _value.searchModel
          // ignore: cast_nullable_to_non_nullable
          : searchModel as SearchModel?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as SearchStatus,
    );
  }
}

extension $SearchStateCopyWith on SearchState {
  /// Returns a callable class that can be used as follows: `instanceOfclass SearchState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass SearchState extends Equatable.name.copyWith.fieldName(...)`.
  _$SearchStateCWProxy get copyWith => _$SearchStateCWProxyImpl(this);
}
