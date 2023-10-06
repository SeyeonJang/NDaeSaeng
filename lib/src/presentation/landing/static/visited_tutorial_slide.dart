class VisitedTutorialSlide {
  static bool first = false;
  static bool second = false;
  static bool third = false;
  static bool fourth = false;

  static isNowIndex(int index) {
    if (index == 0) return first;
    if (index == 1) return second;
    if (index == 2) return third;
    if (index == 3) return fourth;
    return false;
  }

  static visit(int index) {
    switch (index) {
      case 0:
        first = true;
        second = false;
        third = false;
        fourth = false;
        break;

      case 1:
        first = false;
        second = true;
        third = false;
        fourth = false;
        break;
      case 2:
        first = false;
        second = false;
        third = true;
        fourth = false;
        break;
      case 3:
        first = false;
        second = false;
        third = false;
        fourth = true;
        break;
    }
  }
}