import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/api_errors.dart';
import '../common/helpers.dart';
import '../cubits/event.dart';
import '../cubits/profile.dart';
import '../models/event.dart';

class AgendaListTile extends StatefulWidget {
  AgendaListTile({
    required this.event,
    this.fullDate = false,
    this.onTap,
    this.showAddButton = true,
  });

  final EventModel event;
  final bool fullDate;
  final bool showAddButton;
  final void Function()? onTap;

  @override
  State<StatefulWidget> createState() => _AgendaListTileState(
    event: event,
    fullDate: fullDate,
    showAddButton: showAddButton,
    onTap: onTap
  );

}

class _AgendaListTileState extends State<AgendaListTile> {
  _AgendaListTileState({
    required this.event,
    this.fullDate = false,
    this.onTap,
    this.showAddButton = true,
  });
  final EventModel event;
  final bool fullDate;
  final bool showAddButton;
  bool _isLoading = false;
  final void Function()? onTap;

  bool isInPersonalAgenda(BuildContext context) =>
      context.read<ProfileCubit>().state.profile?.personalAgenda.contains(event.id) ?? false;

  void personalAgendaAction(BuildContext context) {
    load(() async {
      setState(() {_isLoading = true;});
      if (isInPersonalAgenda(context)) {
        await context.read<EventCubit>().removeEventFromPersonalAgenda(event);
        if (context.read<ProfileCubit>().state.profile == null) return;
        final events = context.read<ProfileCubit>().state.profile!.personalAgenda;
        context.read<ProfileCubit>().state.profile!.personalAgenda = events.where((element) => element != event.id);
      } else {
        await context.read<EventCubit>().addEventToPersonalAgenda(event);
        if (context.read<ProfileCubit>().state.profile == null) return;
        final events = context.read<ProfileCubit>().state.profile!.personalAgenda;
        context.read<ProfileCubit>().state.profile!.personalAgenda = [...events, event.id];
      }
      setState(() {_isLoading = false;});
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = event.title;
    final description = event.description;
    var time = '${event.startDate.toTime()} - ${event.endDate.toTime()}';
    if (fullDate) {
      time = event.startDate.toDate() + ' ' + time;
    }

    return InkWell(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            title,
                            style: const TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            )
                        ),
                        const SizedBox(height: 8),
                        Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15
                            )
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              time,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.link_outlined),
                      visualDensity: VisualDensity.compact,
                      color: Colors.cyan,
                      onPressed: () {
                        BotToast.showNotification(
                          title: (_) => const Text('There is no link provided'),
                        );
                      },
                    ),
                    Visibility(
                      visible: showAddButton,
                      child: IconButton(
                        icon: Icon(
                          isInPersonalAgenda(context)
                              ? Icons.remove_circle_outline
                              : Icons.calendar_today_outlined,
                        ),
                        visualDensity: VisualDensity.compact,
                        color: Colors.cyan,
                        onPressed: _isLoading ? null : () => personalAgendaAction(context),
                      ),
                    )
                  ],
                )
              ],
            )
        )
    );
  }
}
