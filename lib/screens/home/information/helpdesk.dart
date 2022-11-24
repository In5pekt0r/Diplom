import 'package:flutter/material.dart';

//todo dropdown text
class HelpDesk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 28),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'The Emirates Policy Center (EPC) is an endependet think tank based in ABO DHABI,UNITED ARAB EMIRATE convenes the 8th Annual Abu Dhabi Strategic Debate (ADSD). The event is scheduled to take place from 13-15 Novenber 2021, at the Emirates Palace in Abu Dhabi.',
              ),
            )
          ],
        )
    );
  }
}
