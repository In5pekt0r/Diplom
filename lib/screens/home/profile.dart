part of '../home.dart';

final profileNavigatorKey = GlobalKey<NavigatorState>();
NavigatorState? get profileNavigator => profileNavigatorKey.currentState;

class HomeProfile extends StatelessWidget {
  const HomeProfile({Key? key}) : super(key: key);

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/My Profile',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) =>
            _ProfilePage(profile: state.profile)
    );
    // return WillPopScope(
    //   onWillPop: () async => !await profileNavigator!.maybePop(),
    //   child: Navigator(
    //     key: profileNavigatorKey,
    //     // observers: [MyNavigatorObserver()],
    //     onGenerateRoute: (_) =>
    //       MaterialPageRoute<void>(
    //         settings: RouteSettings(name: getRoute().settings.name),
    //         builder: (_) => BlocBuilder<ProfileCubit, ProfileState>(
    //           builder: (context, state) =>
    //             _ProfilePage(profile: state.profile)
    //         )
    //       ),
    //   )
    // );
  }
}

class _ProfilePageListItem {
  _ProfilePageListItem({
    required this.title,
    required this.icon,
    required this.value
  });
  final String title;
  final IconData icon;
  final String? value;
}

class _ProfilePage extends StatelessWidget {
  _ProfilePage({
    this.profile
  });
  final ProfileModel? profile;
  late final Iterable<_ProfilePageListItem> data = [
    _ProfilePageListItem(
      title: 'Email',
      icon: Icons.mail_outline,
      value: profile?.email
    ),
    _ProfilePageListItem(
      title: 'Phone',
      icon: Icons.phone_android_outlined,
      value: profile?.phone
    ),
    _ProfilePageListItem(
      title: 'Designation',
      icon: Icons.place_outlined,
      value: profile?.designation
    ),
    _ProfilePageListItem(
      title: 'Organization',
      icon: Icons.maps_home_work_outlined,
      value: profile?.organization
    ),
    _ProfilePageListItem(
      title: 'Country of residency',
      icon: Icons.flag_outlined,
      value: profile?.country
    ),
    _ProfilePageListItem(
      title: 'Bio',
      icon: Icons.person_outlined,
      value: profile?.bio
    ),
  ];

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
              expandedHeight: 286,
              toolbarHeight: 0,
              collapsedHeight: 4,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 230,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                                blurRadius: 4
                              )
                            ]
                          ),
                          child: HeroImage(
                            imageLink: profile?.avatarUrl,
                            imageName: 'assets/images/home_profile_avatar.jpeg',
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -8),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade700.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(16)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${profile?.prefix} ${profile?.firstName} ${profile?.lastName}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${profile?.designation}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ]
                                ),
                              )
                          ),
                        )
                      ],
                    )
                  ]
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(44),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: BlueRoundedButton(
                          text: 'Edit Profile',
                          dense: true,
                          onPress: null//() {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: BlueRoundedButton(
                          text: 'Change Password',
                          dense: true,
                          onPress: null//() {},
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ),
          )
        ];
      },
      body: SafeArea(
        top: true,
        bottom: false,
        child: Builder(
          builder: (context) {
            return CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 140),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      data.where((e) => e.value != null).map((e) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    e.icon,
                                    color: Colors.lightBlue
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    e.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                    )
                                  ),
                                ]
                              ),
                              const SizedBox(width: 12),
                              Flexible(
                                child: Text(
                                  e.value!,
                                  textAlign: TextAlign.end,
                                )
                              ),
                            ],
                          ),
                        )
                      ).toList()
                    ),
                  )
                )
              ]
            );
          },
        )
      ),
    );
  }

}
