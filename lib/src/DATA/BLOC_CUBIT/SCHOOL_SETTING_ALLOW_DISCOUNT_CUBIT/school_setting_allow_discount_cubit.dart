import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/schoolSettingAllowDiscountRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'school_setting_allow_discount_state.dart';

class SchoolSettingAllowDiscountCubit extends Cubit<SchoolSettingAllowDiscountState> {
  final SchoolSettingAllowDiscountRepository _repository;
  SchoolSettingAllowDiscountCubit(this._repository) : super(SchoolSettingAllowDiscountInitial());

  Future<void> schoolSettingAllowDiscountCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(SchoolSettingAllowDiscountLoadInProgress());
        final data = await _repository.schoolSettingAllowDiscountData(requestPayload);
        emit(SchoolSettingAllowDiscountLoadSuccess(data));
      } catch (e) {
        emit(SchoolSettingAllowDiscountLoadFail("$e"));
      }
    } else {
      emit(SchoolSettingAllowDiscountLoadFail(NO_INTERNET));
    }
  }
}