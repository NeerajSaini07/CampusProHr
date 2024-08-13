import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/activityApi.dart';
import 'package:campus_pro/src/DATA/API_SERVICES/profileEditRequestApi.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';

abstract class ProfileEditRequestRepositoryAbs {
  Future<bool> profileEditRequest(
      Map<String, String> editData, File? _pickedImage);
}

class ProfileEditRequestRepository extends ProfileEditRequestRepositoryAbs {
  final ProfileEditRequestApi _api;
  ProfileEditRequestRepository(this._api);
  @override
  Future<bool> profileEditRequest(
      Map<String, String> editData, File? _pickedImage) async {
    final data = await _api.profileEditRequest(editData, _pickedImage);
    return data;
  }
}
