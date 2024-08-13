import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/feedbackEnquiryApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/profileEditRequestApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/viewEnquiryApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feedbackEnquiryModel.dart';

abstract class FeedbackEnquiryRepositoryAbs {
  Future<List<FeedbackEnquiryModel>> feedbackEnquiry(
      Map<String, String> feedbackData);
}

class FeedbackEnquiryRepository extends FeedbackEnquiryRepositoryAbs {
  final FeedbackEnquiryApi _api;
  FeedbackEnquiryRepository(this._api);
  @override
  Future<List<FeedbackEnquiryModel>> feedbackEnquiry(
      Map<String, String?> feedbackData) async {
    final data = await _api.feedbackEnquiry(feedbackData);
    return data;
  }
}
