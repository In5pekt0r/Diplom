import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_conference/screens/home/notifications.dart';

import '../cubits/authentication.dart';
import '../screens/home.dart';
import 'droplet_painter.dart';
import 'header.dart';

class ADSDAppBar extends StatefulWidget implements PreferredSizeWidget {
  ADSDAppBar({
    GlobalKey<ADSDAppBarState>? key,
    required this.mainScaffoldKey
  }) : super(key: key);
  final GlobalKey<ScaffoldState> mainScaffoldKey;

  @override
  State<StatefulWidget> createState() => ADSDAppBarState(
    mainScaffoldKey: mainScaffoldKey
  );

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class ADSDAppBarState extends State<ADSDAppBar> with TickerProviderStateMixin {
  ADSDAppBarState({required this.mainScaffoldKey});
  final GlobalKey<ScaffoldState> mainScaffoldKey;

  String _title = '';
  bool _isRoot = true;

  Widget? animatedBackButton;
  Widget? animatedTitle;

  bool get isTitleNotSet => _title.isEmpty;

  void setBackButtonToArrow() {
    animatedBackButton = IconButton(
      key: const ValueKey(1),
      padding: const EdgeInsets.only(left: 4),
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: onBackButtonPress,
      color: Colors.lightBlue,
    );
  }

  void setBackButtonToLogOut() {
    animatedBackButton = IconButton(
      key: const ValueKey(2),
      icon: const Icon(Icons.exit_to_app),
      onPressed: onBackButtonPress,
      color: Colors.lightBlue,
    );
  }

  void setTitleAnimated(String title) {
    _title = title;
    animatedTitle = NavigationHeader(
        title: title,
        key: ValueKey(title),
        onlyTitle: true
    );
  }

  void setTitle({required String title, bool isRoot = false, bool insideSetState = false}) {
    // print('ADSDAppBarState\tsetTitle\t$title\tstart');
    if (_title == title && _isRoot == isRoot) { return; }
    // print('ADSDAppBarState\tsetTitle\t$title\ttitle and root not null');
    void setStuff() {
      setTitleAnimated(title);
      _isRoot = isRoot;
      if (_isRoot) {
        setBackButtonToLogOut();
      } else {
        setBackButtonToArrow();
      }
    }

    if (insideSetState) {
      setStuff();
    } else {
      setState(() {
        setStuff();
      });
    }
  }

  void onBackButtonPress() {
    if (_isRoot) {
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
    } else {
      // BackButton().onPressed!();
      // Navigator.of(context).maybePop();
      Navigator.maybePop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SafeArea(
          child: Stack(
            children: [
              // Top sausage bar
              Transform.translate(
                offset: const Offset(0, -16),
                child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                            blurRadius: 2,
                          )
                        ]
                    )
                ),
              ),
              // Side grey droplets
              Transform.translate(
                offset: const Offset(0, 26),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        SizedBox(
                            height: 108,
                            width: 45,
                            child: CustomPaint(painter: DropletPainter(isLeftSided: true))
                        ),
                        Spacer(),
                        SizedBox(
                            height: 108,
                            width: 45,
                            child: CustomPaint(painter: DropletPainter(isLeftSided: false))
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // buttons, logo & title
        Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      IntrinsicWidth(
                        child: IntrinsicHeight(
                          child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 100),
                              child: animatedBackButton
                          ),
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        'assets/images/ADSD_Logo_small.png',
                        fit: BoxFit.contain,
                        height: 54,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(16))
                            ),
                            backgroundColor: const Color(0xffF7F7F7),
                            builder: (context) => DraggableScrollableSheet(
                                initialChildSize: 0.6,
                                minChildSize: 0.4,
                                maxChildSize: 0.85,
                                expand: false,
                                builder: (context, controller) =>
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.remove,
                                          color: Colors.grey[600],
                                        ),
                                        Expanded(
                                          child: NotificationsScreen(controller: controller),
                                        )
                                      ],
                                    )
                            ),
                          );
                        },
                        color: Colors.lightBlue,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.align_horizontal_left_sharp),
                      onPressed: () { mainScaffoldKey.currentState?.openDrawer(); },
                      color: Colors.white,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: IntrinsicWidth(
                          child: IntrinsicHeight(
                            child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 100),
                                child: animatedTitle
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                        offset: const Offset(0, 2),
                        child: Transform.scale(
                          scaleX: -1.0,
                          child: const IconButton(
                            icon: Icon(Icons.chat_bubble_outline_rounded),
                            onPressed: null,
                            disabledColor: Colors.white24,
                            color: Colors.white,
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
