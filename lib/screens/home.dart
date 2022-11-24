import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/common/route.dart';
import 'package:webrtc_conference/cubits/authentication.dart';
import 'package:webrtc_conference/cubits/search.dart';
import 'package:webrtc_conference/main.dart';

import 'package:webrtc_conference/screens/common/event.dart';
import 'package:webrtc_conference/screens/home/feed/my_agenda.dart';
import 'package:webrtc_conference/widgets/blue_rounded_button.dart';
import 'package:webrtc_conference/widgets/hero_image.dart';
import 'package:webrtc_conference/screens/home/information/attractions.dart';
import 'package:webrtc_conference/screens/home/information/dinner.dart';
import 'package:webrtc_conference/screens/home/information/event_registration.dart';
import 'package:webrtc_conference/screens/home/information/helpdesk.dart';
import 'package:webrtc_conference/screens/home/information/how_to_use_mic.dart';
import 'package:webrtc_conference/screens/home/information/map.dart';
import 'package:webrtc_conference/screens/home/information/wifi_credentials.dart';
import 'package:webrtc_conference/screens/home/feed/polls.dart';
import 'package:webrtc_conference/screens/home/feed/pressroom.dart';

import '../common/app_bar_title_manager.dart';
import '../common/helpers.dart';
import '../cubits/profile.dart';
import '../models/profile.dart';
import '../models/search.dart';
import '../widgets/adsd_app_bar.dart';
import '../widgets/blue_rounded_text_input.dart';
import '../widgets/fab_bottom_app_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/underlined_title.dart';
import 'common/attendee.dart';
import 'common/speaker.dart';
import 'home/feed/agenda.dart';
import 'home/feed/news.dart';
import 'home/feed/speakers.dart';
import 'home/information/about_adsd.dart';
import 'home/information/about_us.dart';
import 'home/feed/attendees.dart';

part 'home/contact.dart';
part 'home/information.dart';
part 'home/feed.dart';
part 'home/profile.dart';
part 'home/search.dart';

// final GlobalKey<ScaffoldState> mainScaffoldKey = GlobalKey();
// final GlobalKey<ADSDAppBarState> appBarKey = GlobalKey();

// final appBarTitleManager = TitleManager();

enum HomeTabValue { contact, information, feed, search, profile }

// extension NameOfHomeTabValue on HomeTabValue {
//   String get formattedName => name.toCapitalised();
// }

// extension CapitalisedString on String {
//   String toCapitalised() => this[0].toUpperCase() + substring(1).toLowerCase();
// }



class MyNavigatorObserver extends NavigatorObserver {
  MyNavigatorObserver({required this.titleManager});
  final TitleManager titleManager;
  @override
  void didPush(Route route, Route? previousRoute) {
    // print('MyNavigatorObserver\tdidPush\tbefore');
    // print(route);
    titleManager.setTitleWithRoute(route);
    // print('MyNavigatorObserver\tdidPush\tafter');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // print('MyNavigatorObserver\tdidPop\tbefore');
    titleManager.setTitleWithRoute(previousRoute);
    // print('MyNavigatorObserver\tdidPop\tafter');
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({required this.profile, Key? key}) : super(key: key);
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/',
      builder: (_) => this,
    );
  }

  final ProfileModel profile;

  @override
  _HomeScreenState createState() => _HomeScreenState(profile: profile);
}

class HomeScreenPage<T> {
  HomeScreenPage({
    required this.homeTab,
    required this.getRoute,
    required this.iconData,
  }) : navigator = GlobalKey<NavigatorState>(debugLabel: homeTab.name),
      appBarState = GlobalKey<ADSDAppBarState>(debugLabel: homeTab.name);
  final HomeTabValue homeTab;
  // final T screen;
  final Route<T> Function() getRoute;
  final IconData iconData;
  final GlobalKey<NavigatorState> navigator;
  final GlobalKey<ADSDAppBarState> appBarState;
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState({required this.profile});
  final ProfileModel profile;

  GlobalKey<ScaffoldState> mainScaffoldKey = GlobalKey();

  int pageIndex = HomeTabValue.feed.index;

  late List<HomeScreenPage> tabs = [
    HomeScreenPage(
      homeTab: HomeTabValue.contact,
      iconData: Icons.mail_outline,
      getRoute: () => const HomeContact().getRoute(),
      // screen: const HomeContact()
    ),
    HomeScreenPage(
      homeTab: HomeTabValue.information,
      iconData: Icons.info_outline,
      getRoute: () => const HomeInformation().getRoute(),
      // screen: const HomeInformation()
    ),
    HomeScreenPage(
      homeTab: HomeTabValue.feed,
      iconData: Icons.home_outlined,
      getRoute: () => HomeFeed(profile: profile).getRoute(),
      // navigator: feedNavigatorKey,
      // screen: const HomeFeed()
    ),
    HomeScreenPage(
        homeTab: HomeTabValue.search,
        iconData: Icons.search_outlined,
      getRoute: () => const HomeSearch().getRoute(),
        // navigator: searchNavigatorKey,
        // screen: const HomeSearch()
    ),
    HomeScreenPage(
      homeTab: HomeTabValue.profile,
      iconData: Icons.person,
      getRoute: () => const HomeProfile().getRoute(),
      // navigator: profileNavigatorKey,
      // screen: const HomeProfile()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: mainScaffoldKey,
        backgroundColor: Colors.white,
        extendBody: true,
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(
            backgroundColor: Colors.white,
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(-1, 1),
                  colors: [Colors.cyan, Colors.white],
                  radius: 1,
                ),
              ),
              child: ListView(
                children: <Widget>[
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(
                            backgroundImage:
                            const AssetImage('assets/images/home_profile_avatar.jpeg'),
                            foregroundImage: state.profile?.avatarUrl != null
                                ? CachedNetworkImageProvider(state.profile!.avatarUrl!)
                            // NetworkImage(state.profile!.avatarUrl!)
                                : null,
                            radius: 45,
                          ),
                          decoration: const BoxDecoration(color: Colors.white),
                          margin: EdgeInsets.zero,
                          accountName: Text(
                              state.profile?.firstName ?? '',
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black
                            ),
                          ),
                          accountEmail: Text(
                            state.profile?.email ?? '',
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black
                            ),
                          )
                      );
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  ListTile(
                    title: const Text('Home'),
                    horizontalTitleGap: 0,
                    leading:
                        const Icon(Icons.home_outlined, color: Colors.cyan),
                    onTap: () {
                      navigator?.pop();
                      goToTab(HomeTabValue.feed);
                    },
                  ),
                  ListTile(
                    title: const Text('Profile'),
                    horizontalTitleGap: 0,
                    leading:
                        const Icon(Icons.person_outlined, color: Colors.cyan),
                    onTap: () {
                      navigator?.pop();
                      goToTab(HomeTabValue.profile);
                    },
                  ),
                  ListTile(
                    title: const Text('About us'),
                    horizontalTitleGap: 0,
                    leading:
                        const Icon(Icons.info_outlined, color: Colors.cyan),
                    onTap: () {
                      navigator?.pop();
                      goToTab(HomeTabValue.information);
                    },
                  ),
                  ListTile(
                    title: const Text('Contact us'),
                    horizontalTitleGap: 0,
                    leading:
                        const Icon(Icons.phone_outlined, color: Colors.cyan),
                    onTap: () {
                      navigator?.pop();
                      goToTab(HomeTabValue.contact);
                    },
                  ),
                  ListTile(
                    title: const Text('Log out'),
                    horizontalTitleGap: 0,
                    leading: const Icon(Icons.logout, color: Colors.cyan),
                    onTap: () {

                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Are you sure you want to leave your account?'),
                            content: const Text('You will need to enter your username and password to enter your account'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                  context.read<AuthenticationCubit>().requestLogout();
                                },
                                child: const Text(
                                    'OK',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ),
                            ],
                          )
                      );
                      // context.read<AuthenticationCubit>().requestLogout();
                    },
                  ),
                ],
              ),
            )),
        bottomNavigationBar: FABBottomAppBar(
          color: Colors.white,
          backgroundColor: const Color.fromRGBO(84, 116, 129, 1),
          selectedColor: Colors.transparent,
          notchedShape: const CircularNotchedRectangle(),
          onTabSelected: onTapHandler,
          iconSize: 28,
          selectedIndex: pageIndex,
          items: tabs.map((tab) =>
            FABBottomAppBarItem(iconData: tab.iconData, text: tab.homeTab.name)
          ).toList()
        ),
        floatingActionButtonAnimator: MyFloatingActionButtonAnimator(),
        floatingActionButtonLocation: MyFloatingActionButtonLocation(itemIndex: pageIndex),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onTapHandler(pageIndex);
          },
          backgroundColor: Colors.white,
          foregroundColor: Colors.lightBlue,
          child: Icon(
            tabs[pageIndex].iconData,
            size: 36,
          ),
          elevation: 2.0,
        ),
        body: IndexedStack(
          index: pageIndex,
          children: tabs.map((t) =>
            WillPopScope(
              onWillPop: () async => !await t.navigator.currentState!.maybePop(),
              child: Scaffold(
                appBar: ADSDAppBar(key: t.appBarState, mainScaffoldKey: mainScaffoldKey),
                backgroundColor: Colors.white,
                body: Navigator(
                    key: t.navigator,
                    observers: [MyNavigatorObserver(titleManager: TitleManager(appBarKey: t.appBarState))],
                    onGenerateRoute: (_) => t.getRoute()
                ),
              )
            )
          ).toList(),
        )
    );
  }

  void goToTab(HomeTabValue tab) {
    onTapHandler(tab.index);
  }

  void onTapHandler(int index) {
    if (pageIndex == index) {
      // press on the current tab => pop to root
      tabs[pageIndex].navigator.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        pageIndex = index;
      });
    }
  }
}
