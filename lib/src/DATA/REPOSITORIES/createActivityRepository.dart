import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/createActivityApi.dart';

abstract class CreateActivityRepoAbs {
  Future<String> createActivityData(
      Map<String, String> sendActivity, List<File>? image);
}

class CreateActivityRepository extends CreateActivityRepoAbs {
  final CreateActivityApi _api;
  CreateActivityRepository(this._api);
  @override
  Future<String> createActivityData(
      Map<String, String> sendActivity, List<File>? image) async {
    final data = await _api.createActivityData(sendActivity, image);
    return data;
  }
}
