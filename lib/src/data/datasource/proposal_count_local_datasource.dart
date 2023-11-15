import 'package:dart_flutter/src/common/util/shared_preferences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProposalCountLocalDatasource {
  static final SharedPreferences prefs = SharedPreferencesUtil.getInstance();
  static const KEY_PROPOSAL_COUNT = "proposal";
  static const KEY_LAST_UPDATE_DATE = "last_update_date";
  static const KEY_LAST_ADMOB_DATE = "last_admob_date";
  static const ADMOB_INTERVAL = 60;
  static const MAX_PROPOSAL = 3;

  static int getLeftProposal() {
    return prefs.getInt(KEY_PROPOSAL_COUNT) ?? 0;
  }
  
  static DateTime getLastUpdateDate() {
    return DateTime.parse(
        prefs.getString(KEY_LAST_UPDATE_DATE)
            ?? DateTime.now().subtract(const Duration(days: 1)).toString()
    );
  }

  static DateTime getLastAdmobDate() {
    return DateTime.parse(
      prefs.getString(KEY_LAST_ADMOB_DATE)
          ?? DateTime.now().subtract(const Duration(days: 1)).toString()
    );
  }

  static Future<void> setLastAdmobDate(DateTime dateTime) async {
    await prefs.setString(KEY_LAST_ADMOB_DATE, dateTime.toString());
  }

  static Future<void> setDailyProposal() async {
    await prefs.setInt(KEY_PROPOSAL_COUNT, MAX_PROPOSAL);
    await prefs.setString(KEY_LAST_UPDATE_DATE, DateTime.now().toString());
  }

  static Future<void> setProposal(int newProposal) async {
    await prefs.setInt(KEY_PROPOSAL_COUNT, newProposal);
  }
}
