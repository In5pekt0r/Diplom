import 'package:flutter/material.dart';

class AttractionItemData {
  AttractionItemData({
    required this.title,
    required this.googleMapLink,
    required this.imageLink,
  });
  final String title;
  final String googleMapLink;
  final String imageLink;
}

class Attractions extends StatelessWidget {
  final List<AttractionItemData> data = [
    AttractionItemData(
      title: 'Emirate Palace',
      googleMapLink: 'On Google Map',
      imageLink: 'assets/images/welcoming-dinner.jpeg',
    ),
    AttractionItemData(
      title: 'Louvre Abu Dhabi',
      googleMapLink: 'On Google Map',
      imageLink: 'assets/images/first-day-dinner.jpeg',
    ),
    AttractionItemData(
      title: 'Farewell Dinner',
      googleMapLink: 'On Google Map',
      imageLink: 'assets/images/farewell-dinner.jpeg',
    ),
  ];

  Widget listTile(AttractionItemData attraction) {
    return Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
                attraction.imageLink,
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
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            attraction.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            )
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.pin_drop_outlined,
                              color: Colors.lightBlue,
                              size: 16
                            ),
                            SizedBox(width: 4),
                            Text(
                              'On Google Map',
                              style: TextStyle(
                                  color: Colors.lightBlue
                              )
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
              height: 10,
              color: Colors.transparent
          );
        },
        itemBuilder: (BuildContext context, int index) =>
            listTile(data[index])
    );
  }
}
