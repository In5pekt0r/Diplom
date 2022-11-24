import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/models/notification.dart';

import '../repositories/database.dart';

part 'notifications.g.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(DatabaseRepository repository)
      : _repository = repository,
        super(const NotificationsState());

  final DatabaseRepository _repository;

  Future<void> load() async {
    if (state.status == NotificationsStatus.loading) return;
    emit(state.copyWith(status: NotificationsStatus.loading));
    try {
      final notifications = await _repository.loadNotifications();
      emit(state.copyWith(notifications: notifications, status: NotificationsStatus.ready));
    } catch (_) {
      emit(state.copyWith(status: NotificationsStatus.error));
      rethrow;
    }
  }
}

enum NotificationsStatus { initial, loading, error, ready }

@CopyWith()
class NotificationsState extends Equatable {
  const NotificationsState({
    this.notifications = const {},
    this.status = NotificationsStatus.initial,
  });

  final Iterable<NotificationModel> notifications;
  final NotificationsStatus status;

  @override
  List<Object> get props =>
      <Object>[] + [status] + notifications.toList();
}
