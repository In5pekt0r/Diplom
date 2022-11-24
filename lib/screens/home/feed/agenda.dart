import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:webrtc_conference/screens/common/event.dart';
import 'package:webrtc_conference/screens/home.dart';

import '../../../cubits/agenda.dart';
import '../../../models/event.dart';
import '../../../widgets/agenda_list_tile.dart';
import '../../../widgets/hero_image.dart';

class AgendaScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Agenda',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AgendaList(),
    );
  }
}

class AgendaList extends StatefulWidget {
  @override
  State<AgendaList> createState() => _AgendaListState();
}

class _AgendaListState extends State<AgendaList> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    load(() => context.read<AgendaCubit>().load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgendaCubit, AgendaState>(
      builder: (BuildContext context, AgendaState state) {
        final cases = {
          AgendaStatus.initial: () => Container(),
          AgendaStatus.loading: () =>
          const Center(child: CircularProgressIndicator()),
          AgendaStatus.error: () {
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
          AgendaStatus.ready: () => AgendaListImpl(
            agenda: state.agenda,
            reload: _load,
          ),
        };
        assert(cases.length == AgendaStatus.values.length);
        return cases[state.status]!();
      },
    );
  }
}

class AgendaListImpl extends StatefulWidget {
  AgendaListImpl({
    required this.agenda,
    required this.reload
  });
  final Iterable<EventModel> agenda;
  final void Function() reload;

  @override
  State<AgendaListImpl> createState() => _AgendaListImplState(
    agenda: agenda,
    reload: reload
  );
}

class _AgendaListImplState extends State<AgendaListImpl> with TickerProviderStateMixin {
  _AgendaListImplState({
    required Iterable<EventModel> agenda,
    required this.reload,
  })
    : agenda = sortedAgenda(agenda);
  final LinkedHashMap<String, Iterable<EventModel>> agenda;

  static LinkedHashMap<String, Iterable<EventModel>> sortedAgenda(Iterable<EventModel> agenda) {
    var agendaEntries = groupBy(agenda, (EventModel e) => e.startDate.toDate())
        .entries
        .toList();
    agendaEntries.sort((a, b) => a.key.compareTo(b.key));
    return LinkedHashMap.fromEntries(agendaEntries);
  }

  final void Function() reload;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: agenda.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.lightBlue,
              pinned: true,
              expandedHeight: 292,
              toolbarHeight: 0,
              collapsedHeight: 10,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: Column(
                  children: [
                    HeroImage(imageName: 'assets/images/agenda_background.png')
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Colors.blueAccent,
                    labelColor: Colors.lightBlue,
                    unselectedLabelColor: Colors.black,
                    tabs: agenda.keys.map((day) =>
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                          child: Tab(
                            child: Text(
                              day,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          )
                        )
                    ).toList(),
                  ),
                ),
              ),
            ),
          )
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: agenda.entries
          .map((entry) => SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (context) {
                return CustomScrollView(
                  key: PageStorageKey<String>(entry.key),
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView
                          .sliverOverlapAbsorberHandleFor(context)
                    ),
                    SliverList(
                      delegate:
                      SliverChildBuilderDelegate((context, _) {
                        return AgendaListView(
                          agenda: entry.value,
                          drawnInScrollable: true,
                          reload: reload,
                        );
                      }, childCount: 1),
                    )
                  ]
                );
              },
            )
          )
        ).toList(),
      ),
    );
  }
}

class AgendaListView extends StatelessWidget {
  AgendaListView({
    required this.agenda,
    this.drawnInScrollable = false,
    this.fullDate = false,
    required this.reload
  });
  final Iterable<EventModel> agenda;
  final bool drawnInScrollable;
  final bool fullDate;
  final void Function() reload;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: agenda.length,
      shrinkWrap: drawnInScrollable,
      physics: drawnInScrollable ? const NeverScrollableScrollPhysics() : null,
      separatorBuilder: (context, index) =>
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: DottedLine(
            dashColor: Colors.grey,
            dashLength: 12.0,
            dashGapLength: 8,
          ),
        ),
      itemBuilder: (BuildContext context, int index) {
        final event = agenda.elementAt(index);
        return AgendaListTile(
          event: event,
          onTap: () async {
            await Navigator.push(context, EventScreen(event: event).getRoute());
            reload();
          },
        );
      },
    );
  }
}
