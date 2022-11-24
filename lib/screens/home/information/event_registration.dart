import 'package:flutter/material.dart';

class EventRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.vpn_key_outlined,
          color: Colors.lightBlue.shade100,
          size: 240
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          'ADSD Is invitation-Only event',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          )
                      ),
                      Container(
                        height: 4,
                        width: 48,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(2)
                        ),
                      )
                    ],
                  ),
                  const Spacer()
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
