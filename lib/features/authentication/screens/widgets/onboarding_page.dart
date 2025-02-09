import 'package:flutter/material.dart';

class onBordingPage extends StatelessWidget {
  const onBordingPage({
    super.key, required this.image, required this.title,required this.subtitle1, required this.subtitle2,
  });

  final String image, title, subtitle1,subtitle2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
      children: [
          Image(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .5,
            image: AssetImage(image),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(title,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 8),
              Text(subtitle1, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.start),
              Text(subtitle2, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.start),
            ],
          ),

        ],
      ),
    );
  }
}