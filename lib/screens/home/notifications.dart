import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:webrtc_conference/cubits/notifications.dart';
import 'package:webrtc_conference/models/notification.dart';

import '../../../common/route.dart';
import '../../../models/event.dart';
import '../../../widgets/underlined_title.dart';
import '../../common/helpers.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({this.controller});
  final ScrollController? controller;

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Notifications',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NotificationsList(controller: controller),
    );
  }
}

class NotificationsList extends StatefulWidget {
  NotificationsList({this.controller});
  final ScrollController? controller;
  @override
  State<NotificationsList> createState() => _NotificationsListState(
      controller: controller
  );
}

class _NotificationsListState extends State<NotificationsList> {
  _NotificationsListState({required this.controller});
  final ScrollController? controller;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    load(() => context.read<NotificationsCubit>().load());
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (BuildContext context, NotificationsState state) {
        final cases = {
          NotificationsStatus.initial: () => Container(),
          NotificationsStatus.loading: () =>
          const Center(child: CircularProgressIndicator()),
          NotificationsStatus.error: () {
            return Center(
                child: FloatingActionButton(
                  onPressed: () {
                    BotToast.cleanAll();
                    _load();
                  },
                  child: const Icon(Icons.replay),
                )
            );
          },
          NotificationsStatus.ready: () =>
            _NotificationsListStateImpl(
              notifications: state.notifications,
              controller: controller,
            ),
        };
        assert(cases.length == NotificationsStatus.values.length);
        return cases[state.status]!();
      },
    );
  }
}

class _NotificationsListStateImpl extends StatelessWidget {
  _NotificationsListStateImpl({required this.notifications, required this.controller});
  final Iterable<NotificationModel> notifications;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return GroupedListView<NotificationModel, String>(
      controller: controller,
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      elements: notifications.toList(),
      groupBy: (element) => element.date.toDate(),
      groupSeparatorBuilder: (String groupByValue) =>
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: IntrinsicHeight(
              child: UnderlinedLabel(
                title: groupByValue,
                length: 64,
              )
          ),
        ),
      itemBuilder: (context, notification) =>
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Flexible(
                  child: Text(
                      notification.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
                Text(
                  notification.date.toTime(),
                  style: const TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 15
                  )
                )
              ],
            )
          ),
      itemComparator: (m1, m2) => m1.date.compareTo(m2.date),
      separator: const Divider(),
      useStickyGroupSeparators: true,
      order: GroupedListOrder.DESC,
    );
  }
}
