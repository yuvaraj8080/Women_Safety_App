import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../utils/constants/colors.dart';

class SingleVideoCard extends StatelessWidget {
  const SingleVideoCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final YoutubePlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor:TColors.primaryColor, // Adjust color as needed
            progressColors:ProgressBarColors(
              playedColor:TColors.primaryColor, // Adjust color as needed
              handleColor:TColors.primaryColor, // Adjust color as needed
            ),
          ),
        ),
      ),
    );
  }
}
