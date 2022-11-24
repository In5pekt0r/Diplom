import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HowToUseMic extends StatelessWidget {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'sNS5GOy4D5o',
    flags: const YoutubePlayerFlags(
      mute: false,
      autoPlay: false,
      loop: false,
      isLive: false,
      forceHD: false,
      enableCaption: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            child: Container(
          //padding: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width / 1.2,
          child: const Text(
            'Once you have your lavalier mounted and positioned nicely, the next step is connecting it to your recording device. There are two things to consider here: what kind of device you are plugging it into and whether you need to connect wirelessly or not. This will determine what kind of equipment you need.',
            style: TextStyle(fontSize: 12, color: Colors.black, height: 1.5),
          ),
        )),
        Container(
          padding: const EdgeInsets.all(20),
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
        ),
      ],
    );
  }
}
