import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:webrtc_conference/cubits/event.dart';
import 'package:webrtc_conference/cubits/personal_agenda.dart';
import 'package:webrtc_conference/screens/common/speaker.dart';

import '../../common/api_errors.dart';
import '../../cubits/profile.dart';
import '../../models/event.dart';
import '../../models/speaker.dart';
import '../../widgets/rounded_list_tile.dart';
import '../../widgets/underlined_title.dart';
import '../home.dart';

class EventScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Agenda/Event',
      builder: (_) => this,
    );
  }

  EventScreen({required this.event});
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: EventPage(event: event),
    );
  }
}

class EventPage extends StatefulWidget {
  EventPage({required this.event});
  final EventModel event;
  @override
  State<StatefulWidget> createState() => _EventPageState(event: event);
}

class _EventPageState extends State<EventPage> {
  _EventPageState({required this.event});
  final EventModel event;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    load(() => context.read<EventCubit>().load(event));
  }

  void copyLink() {
    BotToast.showNotification(
      title: (_) => const Text('There is no link provided'),
    );
  }

  bool isInPersonalAgenda(BuildContext context) =>
      context.read<ProfileCubit>().state.profile?.personalAgenda.contains(event.id) ?? false;

  void personalAgendaAction(BuildContext context) {
    load(() async {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (BuildContext context, EventState state) {
        final cases = {
          EventStatus.initial: () => Container(),
          EventStatus.loading: () =>
          const Padding(
              padding: EdgeInsets.only(top: 32),
              child: Center(
                child: CircularProgressIndicator(),
              )
          ),
          EventStatus.error: () {
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
          EventStatus.ready: () => _EventPageStateImpl(
            event: event,
            speakers: state.speakers,
            copyLink: copyLink,
            isInPersonalAgenda: () => isInPersonalAgenda(context),
            personalAgendaAction: () => personalAgendaAction(context),
          ),
        };
        assert(cases.length == EventStatus.values.length);
        return cases[state.status]!();
      },
    );
  }
}

class _EventPageStateImpl extends StatelessWidget {
  _EventPageStateImpl({
    required this.event,
    required this.speakers,
    required this.copyLink,
    required this.isInPersonalAgenda,
    required this.personalAgendaAction,
  });
  final EventModel event;
  final Iterable<SpeakerModel> speakers;
  final void Function() copyLink;
  final bool Function() isInPersonalAgenda;
  final void Function() personalAgendaAction;

  Widget speakersList(Iterable<SpeakerModel> speakers) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: speakers.length,
      separatorBuilder: (context, index) =>
      const Divider(
          height: 10,
          color: Colors.transparent
      ),
      itemBuilder: (context, index) {
        final speaker = speakers.elementAt(index);
        final title = speaker.fullName;
        final subtitle = speaker.bio;

        return RoundedListTile(
          title: title,
          subtitle: subtitle,
          subtitleMaxLines: 2,
          leading: Transform.translate(
            offset: const Offset(0, -6),
            child: CircleAvatar(
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.white,
              backgroundImage:
                speaker.avatarUrl != null
                ? CachedNetworkImageProvider(speaker.avatarUrl!)
                : null
              // NetworkImage(speaker.avatarUrl)
              ,
              radius: 28,
            ),
          ),
          onTap: () {
            Navigator.push(context, SpeakerScreen(speaker: speaker).getRoute());
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = event.title;
    final description = event.description;
    final time = '${event.startDate.toDate()} ${event.startDate.toTime()} - ${event.endDate.toTime()}';
    return ListView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 32),
      children: [
        Text(
            title,
            style: const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
                fontSize: 18
            )
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
        const SizedBox(height: 8),
        UnderlinedLabel(
          title: 'Description',
        ),
        const SizedBox(height: 8),
        Text(
            description,
            style: const TextStyle(
                // color: Colors.grey,
                fontSize: 15
            )
        ),
        const SizedBox(height: 12),
        UnderlinedLabel(
          title: 'Actions',
        ),
        Wrap(
          children: [
            TextButton(
              onPressed: copyLink,
              child: Row(
                children: const [
                  Icon(
                    Icons.link_outlined,
                    color: Colors.cyan,
                  ),
                  SizedBox(width: 6),
                  Text(
                      'Copy Link',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: personalAgendaAction,
              child: Row(
                children: [
                  Icon(
                    isInPersonalAgenda()
                        ? Icons.remove_circle_outline
                        : Icons.calendar_today_outlined,
                    color: Colors.cyan,
                  ),
                  const SizedBox(width: 6),
                  Text(
                      isInPersonalAgenda()
                          ? 'Remove from personal agenda'
                          : 'Add to personal agenda',
                      // 'Add to personal agenda',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        UnderlinedLabel(
          title: 'Speakers',
        ),
        const SizedBox(height: 8),
        speakersList(speakers),
      ],
    );
  }
}

