import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeTypeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feeTypeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fee_type_state.dart';

class FeeTypeCubit extends Cubit<FeeTypeState> {
  final FeeTypeRepository _repository;
  FeeTypeCubit(this._repository) : super(FeeTypeInitial());

  Future<void> feeTypeCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(FeeTypeLoadInProgress());
        final data = await _repository.feeType(feeData);
        emit(FeeTypeLoadSuccess(data));
      } catch (e) {
        emit(FeeTypeLoadFail("$e"));
      }
    } else {
      emit(FeeTypeLoadFail(NO_INTERNET));
    }
  }
}
