
import 'package:campus_pro/src/DATA/API_SERVICES/getCoordinatorListApi.dart';
import 'package:campus_pro/src/DATA/MODELS/getCoordinatorListModel.dart';

abstract class GetCoordinatorListRepositoryAbs{

  Future<List<GetCoordinatorListModel>> getCoordinatorList(Map<String,String?> request);

}
class GetCoordinatorListRepository extends GetCoordinatorListRepositoryAbs{
  final GetCoordinatorListApi _api;

  GetCoordinatorListRepository(this._api);

  Future<List<GetCoordinatorListModel>> getCoordinatorList(Map<String,String?> request){
    var data = _api.getCoordinatorList(request);
    return data;
  }

}