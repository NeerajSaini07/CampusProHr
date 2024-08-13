import 'package:campus_pro/src/DATA/API_SERVICES/account_type_api.dart';
import 'package:campus_pro/src/DATA/MODELS/models.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';

abstract class AccountTypeRepositoryAbs {
  Future<List<AccountType>> getUserType(Map<String, String> userType);
}

class AccountTypeRepository extends AccountTypeRepositoryAbs {
  final AccountTypeApi _api;
  AccountTypeRepository(this._api);

  @override
  Future<List<AccountType>> getUserType(
      Map<String, String> userTypeData) async {
    final data = await _api.getAccountTypes(userTypeData);
    return data;
  }
}
