abstract class Analytics {
  void initialize({String name = "", String key = ""});
  void logEvent(String eventName, {Map<String, dynamic> properties = const {}});
  void setUserId(String userId);
  void setUserInformation(Map<String, dynamic> properties);
}
