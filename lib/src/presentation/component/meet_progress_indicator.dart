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
  });

  final String text;

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
          Text(text, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8)),
          SizedBox(
            height: SizeConfig.defaultSize,
          ),
        ],
      ),
    );
  }
}