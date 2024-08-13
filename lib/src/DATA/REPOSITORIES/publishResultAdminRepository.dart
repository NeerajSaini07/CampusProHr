import 'package:campus_pro/src/DATA/API_SERVICES/publishResultAdminApi.dart';

abstract class PublishResultAdminRepositoryAbs {
  Future<String> getResultPublish(Map<String, String> request);
}

class PublishResultAdminRepository extends PublishResultAdminRepositoryAbs {
  final PublishResultAdminApi api;
  PublishResultAdminRepository(this.api);

  Future<String> getResultPublish(Map<String, String?> request) {
    final data = api.getResultPublish(request);
    return data;
  }
}
