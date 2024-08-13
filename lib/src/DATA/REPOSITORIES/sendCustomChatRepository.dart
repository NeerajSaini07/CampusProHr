import 'dart:io';

import 'package:campus_pro/src/DATA/API_SERVICES/sendCustomChatApi.dart';

abstract class SendCustomChatRepositoryAbs {
  Future<bool> sendCustomChatData(
      Map<String, String> commentData, List<File>? _filePickedList);
}

class SendCustomChatRepository extends SendCustomChatRepositoryAbs {
  final SendCustomChatApi _api;
  SendCustomChatRepository(this._api);

  Future<bool> sendCustomChatData(
      Map<String, String> commentData, List<File>? _filePickedList) async {
    final data = await _api.sendCustomChatData(commentData, _filePickedList);
    return data;
  }
}
