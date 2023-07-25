class AnalyticsUtil {
  static void logEvent(String title, Map<String, dynamic> params) {
    print("LogEventWith: $title, $params");
    // amplitude
  }

  static void setUserId(String userId) {
    print("setUserId: $userId");
  }
}
