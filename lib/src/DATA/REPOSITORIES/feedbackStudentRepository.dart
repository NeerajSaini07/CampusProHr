import 'package:campus_pro/src/DATA/API_SERVICES/feedbackStudentApi.dart';

abstract class FeedbackStudentRepositoryAbs {
  Future<bool> sendFeedBack(Map<String, String> feedbackData);
}

class FeedbackStudentRepository extends FeedbackStudentRepositoryAbs {
  final FeedbackStudentApi _api;
  FeedbackStudentRepository(this._api);

  @override
  Future<bool> sendFeedBack(Map<String, String?> feedbackData) async {
    final data = await _api.sendFeedBack(feedbackData);
    return data;
  }
}
