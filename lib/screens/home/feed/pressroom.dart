import 'package:flutter/material.dart';
import 'package:webrtc_conference/screens/home.dart';
import 'package:webrtc_conference/screens/home/pressroom/adsddownload.dart';
import 'package:webrtc_conference/screens/home/pressroom/partners.dart';
import 'package:webrtc_conference/widgets/rounded_list_tile.dart';

import '../../../common/route.dart';


class PressRoomScreen extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Pressroom',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PressRoomList(),
    );
  }
}

class PressRoomListItemData<T> {
  const PressRoomListItemData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.getRoute
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Route<T> Function() getRoute;
}
class PressRoomList extends StatelessWidget {

  final List<PressRoomListItemData> data = [
    PressRoomListItemData(
        title: 'Download ADSD Agenda',
        subtitle: 'Latest agenda documents available as PDF files',
        icon: Icons.calendar_today_outlined,
        getRoute: () => ADSDDownloadScreen().getRoute()
    ),
    PressRoomListItemData(
        title: 'Partners',
        subtitle: 'See every company we have partnered with',
        icon: Icons.cases_outlined,
        getRoute: () => ADSDPartnersScreen().getRoute()
    ),
    // PressRoomListItemData(
    //     title: 'EPC Videos',
    //     subtitle: 'Check out available recordings of previous events',
    //     icon: Icons.video_camera_back_outlined,
    //     route: EPCVideos().getRoute()
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
      itemCount: data.length,
      separatorBuilder: (context, index) =>
        const Divider(
          height: 8,
          color: Colors.transparent
        ),
      itemBuilder: (context, index) {
        final dataItem = data.elementAt(index);
        return RoundedListTile(
          title: dataItem.title,
          subtitle: dataItem.subtitle,
          subtitleMaxLines: 2,
          leading: Transform.translate(
            offset: const Offset(6, 3),
            child: Icon(
              dataItem.icon,
              size: 36,
              color: Colors.lightBlue,
            ),
          ),
          onTap: () => Navigator.push(context, dataItem.getRoute()),
        );
      },
    );
  }
}

