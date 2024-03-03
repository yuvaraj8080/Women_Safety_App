import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../common/widgets.Login_Signup/appBar/appbar.dart';
import 'SingleVideo_Card.dart';
 // Import the custom card widget

class SingleVideo extends StatefulWidget {
  const SingleVideo({Key? key}) : super(key: key);

  @override
  State<SingleVideo> createState() => _SingleVideoState();
}

class _SingleVideoState extends State<SingleVideo> {
  late YoutubePlayerController _controller1;
  late YoutubePlayerController _controller2;
  late YoutubePlayerController _controller3;
  late YoutubePlayerController _controller4;

  @override
  void initState() {
    super.initState();
    _controller1 = YoutubePlayerController(
      initialVideoId: 'k9Jn0eP-ZVg',
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    _controller2 = YoutubePlayerController(
      initialVideoId: 'KVpxP3ZZtAc',
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    _controller3 = YoutubePlayerController(
      initialVideoId: 'jAh0cU1J5zk',
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    _controller4 = YoutubePlayerController(
      initialVideoId: 'VI0zJhcppzc',
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Learn Self Defence", style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  SingleVideoCard(controller: _controller1),
                  SizedBox(height: 20),
                  SingleVideoCard(controller: _controller2),
                  SizedBox(height: 20),
                  SingleVideoCard(controller: _controller3),
                  SizedBox(height: 20),
                  SingleVideoCard(controller: _controller4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
