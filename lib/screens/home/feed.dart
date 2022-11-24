part of '../home.dart';

// final feedNavigatorKey = GlobalKey<NavigatorState>();
// NavigatorState? get feedNavigator => feedNavigatorKey.currentState;

// final GlobalKey<ADSDAppBarState> feedAppBarKey = GlobalKey();
// final feedAppBarTitleManager = TitleManager(appBarKey: feedAppBarKey);

class HomeFeed extends StatelessWidget {
  const HomeFeed({
    Key? key,
    required this.profile
  }) : super(key: key);

  final ProfileModel profile;

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Welcome, ${profile.firstName}!',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _HomeFeed();
  }
}

class _HomeFeed extends StatelessWidget {
  static const buttonsOffsetOverPicture = true;
  static const List<NewsPost> news = [
    NewsPost(
      title: 'Airport news and in-depth analysis ',
      subtitle: 'Airport news and in-depth analysis....... ',
      imageName: 'assets/images/air_transport.jpeg'
    ),
    NewsPost(
      title: 'Covid & Christmas ',
      subtitle: 'Airport news and in-depth analysis....... ',
      imageName: 'assets/images/airport.jpeg'
    ),
  ];

  String? getUsername(BuildContext context) {
    return context.read<ProfileCubit>().state.profile?.email;
  }

  Widget navigatingButton({
    required IconData? icon,
    required String text,
    void Function()? onPress,
  }) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,
        ),
        onPressed: onPress,
        child: Container(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 30,
                color: Colors.lightBlue,
              ),
              // const SizedBox(height: 3),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            ],
          ),
        )
      ),
    );
  }

  List<Widget> labeledListTile({
    required String title,
    required Widget child,
    void Function()? onTapSeeMore
  }) {
    return [
      InkWell(
        onTap: onTapSeeMore,
        child: UnderlinedLabel(
          title: title,
          valueText: onTapSeeMore != null ? 'See more...' : null,
        )
      ),
      const SizedBox(height: 8),
      child
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeroImage(imageName: 'assets/images/home_background.png'),
          Transform.translate(
            offset: const Offset(0, buttonsOffsetOverPicture ? -64 : 16),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        navigatingButton(
                            icon: Icons.av_timer,
                            text: 'Agenda',
                            onPress: () { Navigator.push(context, AgendaScreen().getRoute()); }
                        ),
                        const SizedBox(width: 16),
                        navigatingButton(
                            icon: Icons.person_pin_outlined,
                            text: 'Speakers',
                            onPress: () { Navigator.push(context, SpeakersScreen().getRoute()); }
                        ),
                        const SizedBox(width: 16),
                        navigatingButton(
                            icon: Icons.people_alt_outlined,
                            text: 'Attendees',
                            onPress: () { Navigator.push(context, AttendeesScreen().getRoute()); }
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        navigatingButton(
                            icon: Icons.person_search_outlined,
                            text: 'My Agenda',
                            onPress: () { Navigator.push(context, MyAgendaScreen().getRoute()); }
                        ),
                        const SizedBox(width: 16),
                        navigatingButton(
                            icon: Icons.perm_media_outlined,
                            text: 'Press Room',
                            onPress: () { Navigator.push(context, PressRoomScreen().getRoute()); }
                        ),
                        const SizedBox(width: 16),
                        navigatingButton(
                            icon: Icons.poll_outlined,
                            text: 'Polls',
                            onPress: () { Navigator.push(context, PollsScreen().getRoute()); }
                        ),
                        // const SizedBox(width: 48),
                      ],
                    ),

                    const SizedBox(height: 20),

                    ...labeledListTile(
                      title: 'News',
                      child: SizedBox(
                        height: 200,
                        child: NewsList(frontPage: true),
                      ),
                      onTapSeeMore: () =>
                          Navigator.push(context, NewsScreen().getRoute())
                    ),
                    const SizedBox(height: 20),
                    ...labeledListTile(
                      title: 'Polls',
                      child: PollsList(
                        onlyOne: true,
                        singleAndNonScrollable: true,
                        horizontalPadding: 0,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}

class NewsPost {
  const NewsPost({
    required this.imageName,
    required this.title,
    required this.subtitle
  });
  final String imageName;
  final String title;
  final String subtitle;
}

