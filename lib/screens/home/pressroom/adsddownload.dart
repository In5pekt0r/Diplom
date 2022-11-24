import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webrtc_conference/cubits/documents.dart';

import '../../../common/helpers.dart';
import '../../../common/route.dart';
import '../../../models/document.dart';

class ADSDDownloadScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Files',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ADSDDownloadPage(),
    );
  }
}

class ADSDDownloadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ADSDDownloadPageState();
}

class _ADSDDownloadPageState extends State<ADSDDownloadPage> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    load(() => context.read<DocumentsCubit>().load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentsCubit, DocumentsState>(
      builder: (BuildContext context, DocumentsState state) {
        final cases = {
          DocumentsStatus.initial: () => Container(),
          DocumentsStatus.loading: () =>
          const Center(child: CircularProgressIndicator()),
          DocumentsStatus.error: () {
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
          DocumentsStatus.ready: () => _ADSDDownloadPageImpl(
            agenda: state.agenda,
            speeches: state.speeches,
          ),
        };
        assert(cases.length == DocumentsStatus.values.length);
        return cases[state.status]!();
      },
    );
  }
}

class _ADSDDownloadPageTabData {
  _ADSDDownloadPageTabData({
    required this.icon,
    required this.title,
    required this.content,
  });
  final IconData icon;
  final String title;
  final Iterable<DocumentModel> content;
}

class _ADSDDownloadPageImpl extends StatefulWidget {
  _ADSDDownloadPageImpl({
    required this.agenda,
    required this.speeches
  });
  final Iterable<DocumentModel> agenda;
  final Iterable<DocumentModel> speeches;
  @override
  State<StatefulWidget> createState() => _ADSDDownloadPageImplState(
    data: [
      _ADSDDownloadPageTabData(
        icon: Icons.perm_contact_calendar_outlined,
        title: 'Agenda',
        content: agenda
      ),
      _ADSDDownloadPageTabData(
          icon: Icons.chat_bubble_outline,
          title: 'Speeches',
          content: speeches
      ),
    ]
  );
}

class _ADSDDownloadPageImplState extends State<_ADSDDownloadPageImpl>
    with TickerProviderStateMixin {
  _ADSDDownloadPageImplState({
    required this.data
  });

  final List<_ADSDDownloadPageTabData> data;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: data.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _launchURL(String? url) async {
    if (url == null) {
      BotToast.showNotification(
        title: (_) => const Text('No link provided'),
      );
      return;
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget listTile(String text, String url) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold
        )
      ),
      trailing: const Icon(Icons.download_outlined),
      onTap: () {
        _launchURL(url);
      },
      iconColor: Colors.lightBlue,
    );
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
              expandedHeight: 200,
              toolbarHeight: 0,
              collapsedHeight: 4,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: Padding(
                  padding: const EdgeInsets.only(bottom: 76),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.lightBlue.shade50,
                        size: 180
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: IntrinsicHeight(
                          child: Column(
                            children: const [
                              Text(
                                  'Download ADSD agenda & speeches',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              Text(
                                  'Here you can download all files, presented to you by the organizer',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54
                                  )
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
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
                    tabs: data
                        .map((tab) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 74,
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
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Transform.translate(
            offset: const Offset(-50, 50),
            child: Icon(
                Icons.calendar_today,
                color: Colors.lightBlue.shade50,
                size: 250
            ),
          ),
          TabBarView(
            controller: _tabController,
            children: data
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
                            SliverPadding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                sliver: SliverList(
                                  delegate: SliverChildListDelegate(
                                      tab.content.map((value) =>
                                          listTile(value.name, value.link)
                                      ).toList()
                                  ),
                                )
                            )
                          ]
                      );
                    },
                )
              )
            ).toList(),
          )
        ],
      ),
    );
  }
}

