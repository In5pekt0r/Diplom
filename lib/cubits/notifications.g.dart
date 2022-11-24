// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationsStateCWProxy {
  NotificationsState notifications(Iterable<NotificationModel> notifications);

  NotificationsState status(NotificationsStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationsState(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationsState call({
    Iterable<NotificationModel>? notifications,
    NotificationsStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationsState.copyWith.fieldName(...)`
class _$NotificationsStateCWProxyImpl implements _$NotificationsStateCWProxy {
  final NotificationsState _value;

  const _$NotificationsStateCWProxyImpl(this._value);

  @override
  NotificationsState notifications(Iterable<NotificationModel> notifications) =>
      this(notifications: notifications);

  @override
  NotificationsState status(NotificationsStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationsState(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationsState call({
    Object? notifications = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return NotificationsState(
      notifications: notifications == const $CopyWithPlaceholder()
          ? _value.notifications
          // ignore: cast_nullable_to_non_nullable
          : notifications as Iterable<NotificationModel>,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as NotificationsStatus,
    );
  }
}

extension $NotificationsStateCopyWith on NotificationsState {
  /// Returns a callable class that can be used as follows: `instanceOfclass NotificationsState extends Equatable.name.copyWith(...)` or like so:`instanceOfclass NotificationsState extends Equatable.name.copyWith.fieldName(...)`.
  _$NotificationsStateCWProxy get copyWith =>
      _$NotificationsStateCWProxyImpl(this);
}
