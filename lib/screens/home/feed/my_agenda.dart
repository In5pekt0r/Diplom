import 'package:bot_toast/bot_toast.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../common/helpers.dart';
import '../../../common/route.dart';
import '../../../cubits/agenda.dart';
import '../../../cubits/personal_agenda.dart';
import '../../../cubits/profile.dart';
import '../../../models/event.dart';
import '../../../widgets/agenda_list_tile.dart';
import '../../../widgets/underlined_title.dart';
import '../../common/event.dart';
import '../../home.dart';

class MyAgendaScreen extends StatelessWidget {
  MyAgendaScreen({
    this.customTitle,
    this.agendaList
  });

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/' + (customTitle ?? 'Personal Agenda'),
      builder: (_) => this,
    );
  }

  final String? customTitle;
  final Iterable<EventModel>? agendaList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MyAgendaList(agendaList: agendaList),
    );
  }
}

class MyAgendaList extends StatefulWidget {
  MyAgendaList({this.agendaList});
  final Iterable<EventModel>? agendaList;
  @override
  State<MyAgendaList> createState() => _MyAgendaListState(agendaList: agendaList);
}

class _MyAgendaListState extends State<MyAgendaList> {
  _MyAgendaListState({this.agendaList});
  final Iterable<EventModel>? agendaList;

  bool get standaloneScreen => agendaList == null;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    if (!standaloneScreen) return;
    load(() async {
      final eventIds = context.read<ProfileCubit>().state.profile?.personalAgenda;
      if (eventIds == null) return;
      await context.read<PersonalAgendaCubit>().load(eventIds);
    });
  }

  void onPress(EventModel event) async {
    await Navigator.push(context, EventScreen(event: event).getRoute());
    if (!standaloneScreen) return;
    _load();
  }

  @override
  Widget build(BuildContext context) {
    if (agendaList != null) {
      return _MyAgendaListImpl(agenda: agendaList!, onPress: onPress);
    }
    return BlocBuilder<PersonalAgendaCubit, PersonalAgendaState>(
      builder: (BuildContext context, PersonalAgendaState state) {
        final cases = {
          PersonalAgendaStatus.initial: () => Container(),
          PersonalAgendaStatus.loading: () =>
          const Center(child: CircularProgressIndicator()),
          PersonalAgendaStatus.error: () {
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
          PersonalAgendaStatus.ready: () => _MyAgendaListImpl(
            agenda: state.agenda,
            onPress: onPress,
          ),
        };
        assert(cases.length == PersonalAgendaStatus.values.length);
        return cases[state.status]!();
      },
    );
  }
}

class _MyAgendaListImpl extends StatelessWidget {
  _MyAgendaListImpl({
    required this.agenda,
    required this.onPress
  });
  final Iterable<EventModel> agenda;
  final void Function(EventModel) onPress;

  @override
  Widget build(BuildContext context) {
    return GroupedListView<EventModel, String>(
      elements: agenda.toList(),
      groupBy: (element) => element.startDate.toDate(),
      groupSeparatorBuilder: (String groupByValue) =>
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: IntrinsicHeight(
              child: UnderlinedLabel(
                title: groupByValue,
                length: 64,
              )
            ),
          ),
      itemBuilder: (context, event) =>
        AgendaListTile(
          event: event,
          onTap: () => onPress(event),

        ),
      separator: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: DottedLine(
          dashColor: Colors.grey,
          dashLength: 12.0,
          dashGapLength: 8,
        ),
      ),
      useStickyGroupSeparators: true,
      order: GroupedListOrder.ASC,
    );
  }
}
