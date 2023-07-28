import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    // iPhone 11 기준 defaultSize는 10 정도
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }

  static double getDefaultSize() {
    return defaultSize;
  }

  static const mainSize = 10.0;
}

double getFlexibleSize({double target = 1}) =>
    SizeConfig.defaultSize * (target / SizeConfig.mainSize);
