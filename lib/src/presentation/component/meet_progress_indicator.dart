import 'package:flutter/material.dart';

import '../../../res/config/size_config.dart';

class MeetProgressIndicator extends StatelessWidget {
  const MeetProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Color(0xffFF5C58),
    );
  }
}

class MeetProgressIndicatorWithMessage extends StatelessWidget {
  const MeetProgressIndicatorWithMessage({
    super.key,
    required this.text,
    this.color = Colors.black
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.defaultSize,
          ),
          const MeetProgressIndicator(),
          SizedBox(height: SizeConfig.defaultSize * 4),
          Text(text, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, color: color)),
          SizedBox(
            height: SizeConfig.defaultSize,
          ),
        ],
      ),
    );
  }
}

class MeetProgressIndicatorFullScreen extends StatelessWidget {
  const MeetProgressIndicatorFullScreen({super.key, this.text = "", this.color = Colors.black, this.opacity = 0.5});

  final String text;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, opacity)),
      child: Center(child: MeetProgressIndicatorWithMessage(text: text, color: color,)),
    );
  }
}
