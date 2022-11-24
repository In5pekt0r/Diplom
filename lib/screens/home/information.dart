part of '../home.dart';

class HomeInformation extends StatelessWidget {
  const HomeInformation({Key? key}) : super(key: key);

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Information',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InformationList();
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //     body: InformationList(),
    // );
  }
}

class InformationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InformationListState();
}

class InformationTabBarData {
  const InformationTabBarData({
    required this.title,
    required this.icon,
    required this.content,
  });
  final String title;
  final IconData icon;
  final Widget content;
}

class _InformationListState extends State<InformationList> with TickerProviderStateMixin {
  static List<InformationTabBarData> tabs = [
    InformationTabBarData(
      title: 'About ADSD',
      icon: Icons.info_outline_rounded,
      content: AboutADSD(),
    ),
    InformationTabBarData(
      title: 'About Us',
      icon: Icons.list_alt,
      content: AboutUs(),
    ),
    InformationTabBarData(
      title: 'ADSD Helpdesk',
      icon: Icons.contact_phone_outlined,
      content: HelpDesk(),
    ),
    InformationTabBarData(
      title: 'Event Registration',
      icon: Icons.menu_book_outlined,
      content: EventRegistration(),
    ),
    InformationTabBarData(
      title: 'Dinner',
      icon: Icons.food_bank_outlined,
      content: Dinner(),
    ),
    InformationTabBarData(
      title: 'Map',
      icon: Icons.map_outlined,
      content: Map(),
    ),
    InformationTabBarData(
      title: 'Abu Dhabi Attractions',
      icon: Icons.attractions,
      content: Attractions(),
    ),
    InformationTabBarData(
      title: 'WiFi Credentials',
      icon: Icons.wifi,
      content: WifiCredentials(),
    ),
    InformationTabBarData(
      title: 'How to Use Mic',
      icon: Icons.mic,
      content: HowToUseMic(),
    ),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          indicator: BoxDecoration(
            color: const Color.fromRGBO(84, 116, 129, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          indicatorPadding: const EdgeInsets.symmetric(vertical: 4),
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: tabs.map((tab) =>
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 80,
                child: Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          tab.icon,
                          // color:
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
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: tabs.map((tab) =>
              tab.content
            ).toList(),
          ),
        )
      ],
    );
  }
}
