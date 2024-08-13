import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/enquiryCommentListApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/profileEditRequestApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/enquiryCommentListModel.dart';

abstract class EnquiryCommentListRepositoryAbs {
  Future<List<EnquiryCommentListModel>> enquiryCommentList(
      Map<String, String> commentData);
}

class EnquiryCommentListRepository extends EnquiryCommentListRepositoryAbs {
  final EnquiryCommentListApi _api;
  EnquiryCommentListRepository(this._api);
  @override
  Future<List<EnquiryCommentListModel>> enquiryCommentList(
      Map<String, String?> commentData) async {
    final data = await _api.enquiryCommentList(commentData);
    return data;
  }
}
