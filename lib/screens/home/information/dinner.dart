import 'package:flutter/material.dart';
import 'package:webrtc_conference/models/event.dart';

class DinnerItemData {
  DinnerItemData({
    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.imageLink,
  });
  final String title;
  final String subtitle;
  final DateTime dateTime;
  final String imageLink;
}

class Dinner extends StatelessWidget {
  final List<DinnerItemData> data = [
    DinnerItemData(
      title: 'Welcoming Dinner',
      subtitle: 'Oriental Gazeba, Emirate Palace, Abu Dhabi, UAE',
      dateTime: DateTime.now(),
      imageLink: 'assets/images/welcoming-dinner.jpeg',
    ),
    DinnerItemData(
      title: 'First day',
      subtitle: 'Oriental Gazeba, Emirate Palace, Abu Dhabi, UAE',
      dateTime: DateTime.now(),
      imageLink: 'assets/images/first-day-dinner.jpeg',
    ),
    DinnerItemData(
      title: 'Farewell Dinner',
      subtitle: 'Oriental Gazeba, Emirate Palace, Abu Dhabi, UAE',
      dateTime: DateTime.now(),
      imageLink: 'assets/images/farewell-dinner.jpeg',
    ),
  ];

  Widget listTile(DinnerItemData dinner) {
    return Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(4),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
                dinner.imageLink,
                fit: BoxFit.fitWidth,
                height: 200,
                width: double.infinity
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            dinner.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            )
                        ),
                        Text(
                            dinner.subtitle
                        ),
                      ],
                    ),
                  ),
                ),
                Transform.translate(
                    offset: const Offset(-32, -40),
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(16),
                          color: Colors.lightBlue.shade100,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              children: [
                                Text(
                                    dinner.dateTime.toShortMonth().toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        height: 1.2
                                    )
                                ),
                                Text(
                                    dinner.dateTime.toShortDay(),
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        height: 1.1
                                    )
                                ),
                                Text(
                                    dinner.dateTime.toTime(),
                                    style: const TextStyle(
                                        color: Colors.blueGrey,
                                        height: 1
                                    )
                                ),
                              ],
                            )
                        )
                    )
                )
              ],
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 140),
      itemCount: data.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 8,
          color: Colors.transparent
        );
      },
      itemBuilder: (BuildContext context, int index) =>
          listTile(data[index])
    );
  }
}
