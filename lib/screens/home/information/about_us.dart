import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:webrtc_conference/widgets/hero_adsd_logo.dart';

class AboutUs extends StatelessWidget {
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scaleX: 2,
                              scaleY: 2,
                              child: Material(
                                elevation: 4,
                                child: HeroADSDLogo(
                                  width: 60,
                                  borderRadius: 4,
                                  inset: 1
                                )
                              ),
                            ),
                            const SizedBox(width: 36),
                            const Flexible(
                              child: Text(
                                  'EMIRATES POLICY CENTER',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        Transform.translate(
                            offset: const Offset(-20, 8),
                            child: Transform.rotate(
                                angle: -pi / 8,
                                child: Text(
                                  '?',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: 20
                                  )
                                )
                            )
                        ),
                        Transform.translate(
                            offset: const Offset(-8, 0),
                            child: Transform.rotate(
                                angle: pi / 16,
                                child: Text(
                                    '?',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 32
                                    )
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
