import 'package:campus_pro/src/DATA/API_SERVICES/drawerApi.dart';
import 'package:campus_pro/src/DATA/MODELS/drawerModel.dart';

abstract class DrawerRespositoryAbs {
  Future<List<DrawerModel>> getDrawerItems(Map<String, String> drawerData, String headerToken);
}

class DrawerRepository extends DrawerRespositoryAbs {
  final DrawerApi _api;

  DrawerRepository(this._api);
  @override
  Future<List<DrawerModel>> getDrawerItems(
      Map<String, String> drawerData, String headerToken) async {
    final data = await _api.getDrawerItems(drawerData, headerToken);
    return data;
  }
}
