import 'package:in_app_review/in_app_review.dart';

class RatingHelper {
  RatingHelper._();

  static final shared = RatingHelper._();

  final InAppReview inAppReview = InAppReview.instance;

  Future<void> requestReview() async {
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    }
  }

  Future<bool> get isAvailable {
    return inAppReview.isAvailable();
  }
}
