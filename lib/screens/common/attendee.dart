import 'package:bot_toast/bot_toast.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webrtc_conference/common/helpers.dart';
import 'package:webrtc_conference/widgets/hero_image.dart';

import '../../../common/route.dart';
import '../../../models/attendee.dart';
import '../../common/api_errors.dart';

class AttendeeScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Attendees/Attendee',
      builder: (_) => this,
    );
  }

  AttendeeScreen({required this.attendee});
  final AttendeeModel attendee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AttendeePage(attendee: attendee)
    );
  }
}

class AttendeePage extends StatefulWidget {
  AttendeePage({required this.attendee});
  final AttendeeModel attendee;
  @override
  State<StatefulWidget> createState() => _AttendeePageState(attendee: attendee);
}

class _AttendeePageState extends State<AttendeePage>
    with TickerProviderStateMixin {
  _AttendeePageState({required this.attendee});
  final AttendeeModel attendee;

  void copyEmail() {
    Clipboard.setData(ClipboardData(text: attendee.email));
    BotToast.showNotification(
      title: (_) => const Text('Successfully copied email'),
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
              expandedHeight: 100,
              toolbarHeight: 0,
              collapsedHeight: 4,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              attendee.fullName,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onLongPress: copyEmail,
                            child: FittedBox(
                              child: Text(
                                attendee.email,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ]
                      ),
                    )
                  ],
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
                  handle:
                  NestedScrollView.sliverOverlapAbsorberHandleFor(context)
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // TODO: Send email button
                      // Row(
                      //   children: const [
                      //     Spacer(),
                      //     Text(
                      //       'Send email',
                      //       style: TextStyle(
                      //         color: Colors.lightBlue
                      //       )
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 4),
                      Text(faker.lorem.sentences(20).join()),
                      const SizedBox(height: 64 + 20),
                    ]),
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
