import 'package:flutter/material.dart';

class WifiCredentials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              //padding: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width / 1.2,
              child: const Text(
                'Name: ADSD_Conference_WIFI',
                style:
                    TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
              ),
            )),
        Container(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              //padding: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width / 1.2,
              child: const Text(
                'Password: 12345679',
                style:
                    TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
              ),
            ))
      ],
    );
  }
}
