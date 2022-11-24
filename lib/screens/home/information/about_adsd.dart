import 'dart:math' show pi;

import 'package:flutter/material.dart';

class AboutADSD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 32),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.lightBlue.shade400
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.translate(
                            offset: const Offset(0, -36),
                            child: const Text(
                                '13-15',
                                style: TextStyle(
                                    color: Color.fromRGBO(84, 116, 129, 1),
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 4),
                                          blurRadius: 10
                                      )
                                    ]
                                )
                            )
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                    'November 21',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )
                                ),
                                Text(
                                    '8th Abu Dhabi Strategic Debate Emirates Palace Hotel, Abu Dhabi, UAE',
                                    style: TextStyle(
                                        color: Colors.white
                                    )
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    Transform.translate(
                        offset: const Offset(-24, -8),
                        child: Transform.rotate(
                            angle: pi / 12,
                            child: Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.white.withOpacity(0.2)
                            )
                        )
                    ),
                    Transform.translate(
                        offset: const Offset(4, -4),
                        child: Transform.rotate(
                            angle: -pi / 6,
                            child: Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.white.withOpacity(0.6),
                              size: 28,
                            )
                        )
                    ),
                  ],
                )
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'The Emirates Policy Center (EPC) convenes the 8th Annual Abu Dhabi Strategic Debate (ADSD). The event is scheduled to take place from 13-15 Novenber 2021, at the Emirates Palace in Abu Dhabi.',
            ),
          )
        ],
      )
    );
  }
}
