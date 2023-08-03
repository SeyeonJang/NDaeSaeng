import 'package:dart_flutter/res/environment/app_environment.dart';
import 'package:dart_flutter/src/common/util/analytics_util.dart';

void main() {
  AppEnvironment.setupEnv(BuildType.dev);
  AnalyticsUtil.initialize();
  AnalyticsUtil.setUserId("0");
  var properties = {"gender": "FEMALE", "admissionYear": 2015, "birthYear": 2004, "university": "소마대학교", "department": "부자학부"};
  AnalyticsUtil.setUserInformation(properties);

  AnalyticsUtil.logEvent("USER PROPERTIES TEST");
}
