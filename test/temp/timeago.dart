import 'package:dart_flutter/src/common/util/timeago_util.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  // Original
  final fifteenAgo = DateTime.now().subtract(Duration(minutes: 15));

  timeago.setLocaleMessages('ko', timeago.KoMessages());

  print(timeago.format(fifteenAgo)); // 15 minutes ago
  print(timeago.format(fifteenAgo, locale: 'ko_short')); // 15m
  print(timeago.format(fifteenAgo, locale: 'ko')); // hace 15 minutos

  print(timeago.format(DateTime.now(), locale: 'ko'));
  print(timeago.format(DateTime.now().subtract(Duration(minutes: 1)), locale: 'ko'));
  print(timeago.format(DateTime.now().subtract(Duration(hours: 1)), locale: 'ko'));

  // MyUtil
  final TimeagoUtil timeagoUtil = TimeagoUtil();
  print(timeagoUtil.format(DateTime.now()));
}
