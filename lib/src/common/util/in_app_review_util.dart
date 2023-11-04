import 'package:in_app_review/in_app_review.dart';

class InAppReviewUtil {
  static final InAppReview inAppReview = InAppReview.instance;

  static Future<void> dialog() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  static void openStore() {
    inAppReview.openStoreListing(appStoreId: '6451335598');
  }
}
