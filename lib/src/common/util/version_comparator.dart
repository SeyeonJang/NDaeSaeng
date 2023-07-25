import 'package:dart_flutter/src/common/auth/state/auth_state.dart';

class VersionComparator {
  static AppVersionStatus compareVersions(String version, String minVer, String latestVer) {
    List<int> versionList = _extractNumbers(version);
    List<int> minVerList = _extractNumbers(minVer);
    List<int> latestVerList = _extractNumbers(latestVer);

    if (_isLessThan(versionList, minVerList)) {
      return AppVersionStatus.mustUpdate;
    } else if (_isLessThan(versionList, latestVerList)) {
      return AppVersionStatus.update;
    } else {
      return AppVersionStatus.latest;
    }
  }

  static List<int> _extractNumbers(String versionString) {
    List<String> numbers = versionString.split('.');
    return numbers.map((e) => int.tryParse(e) ?? 0).toList();
  }

  static bool _isLessThan(List<int> list1, List<int> list2) {
    for (int i = 0; i < list1.length; i++) {
      if (i >= list2.length || list1[i] < list2[i]) {
        return true;
      } else if (list1[i] > list2[i]) {
        return false;
      }
    }
    return false;
  }
}
