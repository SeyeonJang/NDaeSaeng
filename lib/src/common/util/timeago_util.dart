import 'package:timeago/timeago.dart' as timeago;

class TimeagoUtil {
  TimeagoUtil._privateConstructor();
  static final TimeagoUtil _timeagoUtil = TimeagoUtil._privateConstructor();
  factory TimeagoUtil() {
    return _timeagoUtil;
  }

  void initKorean() {
    timeago.setLocaleMessages('ko', timeago.KoMessages());
  }

  String format(DateTime dateTime) {
    return timeago.format(dateTime, locale: 'ko');
  }
}
