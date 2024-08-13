import 'package:campus_pro/src/DATA/API_SERVICES/openMarksheetApi.dart';

abstract class OpenMarksheetRepositoryAbs {
  Future<String> openMarksheet(
      Map<String, String> marksheetData);
}

class OpenMarksheetRepository extends OpenMarksheetRepositoryAbs {
  final OpenMarksheetApi _api;
  OpenMarksheetRepository(this._api);
  @override
  Future<String> openMarksheet(
      Map<String, String> marksheetData) async {
    final data = await _api.openMarksheet(marksheetData);
    return data;
  }
}