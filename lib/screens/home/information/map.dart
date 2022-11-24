import 'package:flutter/material.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 16),
          child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(84, 116, 129, 1),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(
                          Icons.map_outlined,
                          color: Colors.white,
                          size: 36,
                        ),
                        title: Text(
                          'Emirate Place Hotel',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        subtitle: Text(
                          '24.4715958,54.334999,12.29z',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.house_outlined,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      Container(
                          padding:
                          const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: const Image(
                                image: AssetImage('assets/images/map.png'),
                                fit: BoxFit.fitWidth,
                              )
                          )
                      ),
                    ],
                  )
              )
          )
        )
      ],
    );
    // return Column(
    //   children: <Widget>[
    //     Container(
    //       padding: EdgeInsets.symmetric(horizontal: 20),
    //       child: Stack(
    //         clipBehavior: Clip.none,
    //         children: <Widget>[
    //           Container(
    //             height: 300,
    //             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10),
    //               color: Color.fromRGBO(84, 116, 129, 1),
    //             ),
    //             //height: 250,
    //             child: const ListTile(
    //                 leading: Icon(
    //                   Icons.map_outlined,
    //                   color: Colors.white,
    //                   size: 36,
    //                 ),
    //                 title: Text(
    //                   'Emirate Place Hotel',
    //                   style: TextStyle(fontSize: 20, color: Colors.white),
    //                 ),
    //                 subtitle: Text(
    //                   '24.4715958,54.334999,12.29z',
    //                   style: TextStyle(fontSize: 12, color: Colors.white),
    //                 ),
    //                 trailing: Icon(
    //                   Icons.house_outlined,
    //                   color: Colors.white,
    //                   size: 36,
    //                 ),
    //             ),
    //           ),
    //           Container(
    //             padding:
    //               const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: const Image(
    //                 image: AssetImage('assets/images/map.png'),
    //                 fit: BoxFit.fitWidth,
    //               )
    //             )
    //           ),
    //         ],
    //       ),
    //     )
    //   ],
    // );
  }
}
