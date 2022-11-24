// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DocumentsStateCWProxy {
  DocumentsState agenda(Iterable<DocumentModel> agenda);

  DocumentsState speeches(Iterable<DocumentModel> speeches);

  DocumentsState status(DocumentsStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentsState(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentsState call({
    Iterable<DocumentModel>? agenda,
    Iterable<DocumentModel>? speeches,
    DocumentsStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDocumentsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDocumentsState.copyWith.fieldName(...)`
class _$DocumentsStateCWProxyImpl implements _$DocumentsStateCWProxy {
  final DocumentsState _value;

  const _$DocumentsStateCWProxyImpl(this._value);

  @override
  DocumentsState agenda(Iterable<DocumentModel> agenda) => this(agenda: agenda);

  @override
  DocumentsState speeches(Iterable<DocumentModel> speeches) =>
      this(speeches: speeches);

  @override
  DocumentsState status(DocumentsStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DocumentsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DocumentsState(...).copyWith(id: 12, name: "My name")
  /// ````
  DocumentsState call({
    Object? agenda = const $CopyWithPlaceholder(),
    Object? speeches = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return DocumentsState(
      agenda: agenda == const $CopyWithPlaceholder()
          ? _value.agenda
          // ignore: cast_nullable_to_non_nullable
          : agenda as Iterable<DocumentModel>,
      speeches: speeches == const $CopyWithPlaceholder()
          ? _value.speeches
          // ignore: cast_nullable_to_non_nullable
          : speeches as Iterable<DocumentModel>,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as DocumentsStatus,
    );
  }
}

extension $DocumentsStateCopyWith on DocumentsState {
  /// Returns a callable class that can be used as follows: `instanceOfclass DocumentsState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass DocumentsState extends Equatable.name.copyWith.fieldName(...)`.
  _$DocumentsStateCWProxy get copyWith => _$DocumentsStateCWProxyImpl(this);
}
