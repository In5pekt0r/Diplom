import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/widgets/hero_image.dart';

import '../../common/helpers.dart';
import '../../common/route.dart';
import '../../cubits/speaker.dart';
import '../../models/speaker.dart';
import '../home/feed/agenda.dart';

class SpeakerScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Speakers/${speaker.fullName}',
      builder: (_) => this,
    );
  }

  SpeakerScreen({required this.speaker});
  final SpeakerModel speaker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SpeakerPage(speaker: speaker),
    );
  }
}

class SpeakerPage extends StatefulWidget {
  SpeakerPage({required this.speaker});
  final SpeakerModel speaker;

  @override
  State<StatefulWidget> createState() => _SpeakerPageState(speaker: speaker);
}

class SpeakerPageTabBarData {
  SpeakerPageTabBarData(
      {required this.title, required this.icon, required this.content});
  final String title;
  final IconData icon;
  final Widget content;
}

class _SpeakerPageState extends State<SpeakerPage> with TickerProviderStateMixin {
  _SpeakerPageState({required this.speaker});
  final SpeakerModel speaker;

  late List<SpeakerPageTabBarData> tabs = [
    SpeakerPageTabBarData(
        title: 'BIO',
        icon: Icons.card_membership,
        content: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 140),
            child: Text(speaker.bio),
          ),
        ),
    ),
    SpeakerPageTabBarData(
        title: 'Sessions',
        icon: Icons.supervised_user_circle_outlined,
        content: _SpeakerSessionsList(speaker: speaker)
    ),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              expandedHeight: 308,
              toolbarHeight: 0,
              collapsedHeight: 4,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          height: 230,
                          child: HeroImage(
                            imageLink: speaker.avatarUrl,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  speaker.fullName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  speaker.job,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ]
                          ),
                        )
                      ],
                    )
                  ]
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(74),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: const Color.fromRGBO(84, 116, 129, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 74),
                    indicatorPadding: const EdgeInsets.symmetric(vertical: 4),
                    indicatorColor: Colors.blueAccent,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: tabs
                      .map((tab) => Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          height: 74,
                          child: Tab(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    tab.icon,
                                  ),
                                  Text(
                                    tab.title,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                          ),
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
        children: tabs
          .map((tab) => SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (context) {
                return CustomScrollView(
                  key: PageStorageKey<String>(tab.title),
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView
                        .sliverOverlapAbsorberHandleFor(context)
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, _) {
                        return tab.content;
                      }, childCount: 1),
                    )
                  ]
                );
              },
            )
        )).toList(),
      ),
    );
  }
}

class _SpeakerSessionsList extends StatefulWidget {
  _SpeakerSessionsList({
    required this.speaker
  });
  final SpeakerModel speaker;

  @override
  State<_SpeakerSessionsList> createState() =>
      _SpeakerSessionsListState(speaker: speaker);
}

class _SpeakerSessionsListState extends State<_SpeakerSessionsList> {
  _SpeakerSessionsListState({
    required this.speaker
  });
  final SpeakerModel speaker;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    load(() => context.read<SpeakerCubit>().load(speaker));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeakerCubit, SpeakerState>(
      builder: (BuildContext context, SpeakerState state) {
        final cases = {
          SpeakerStatus.initial: () => Container(),
          SpeakerStatus.loading: () =>
            const Padding(
              padding: EdgeInsets.only(top: 32),
              child: Center(
                child: CircularProgressIndicator(),
              )
            ),
          SpeakerStatus.error: () {
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
          SpeakerStatus.ready: () =>
          state.sessions.isEmpty
          ? const Padding(
              padding: EdgeInsets.only(top: 32),
              child: Center(
                child: Text('Ths speaker has no sessions')
              )
            )
          : AgendaListView(
              agenda: state.sessions,
              drawnInScrollable: true,
              fullDate: true,
              reload: _load,
            ),
        };
        assert(cases.length == SpeakerStatus.values.length);
        return cases[state.status]!();
      },
    );
  }
}
