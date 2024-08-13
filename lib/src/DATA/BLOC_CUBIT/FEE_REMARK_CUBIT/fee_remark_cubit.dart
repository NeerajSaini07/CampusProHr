import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/MODELS/feeRemarksModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feeRemarksRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fee_remark_state.dart';

class FeeRemarkCubit extends Cubit<FeeRemarkState> {
  final FeeRemarksRepository _repository;
  FeeRemarkCubit(this._repository) : super(FeeRemarkInitial());

  Future<void> feeRemarkCubitCall(Map<String, String?> feeData) async {
    if (await isInternetPresent()) {
      try {
        emit(FeeRemarkLoadInProgress());
        final data = await _repository.feeRemarks(feeData);
        emit(FeeRemarkLoadSuccess(data));
      } catch (e) {
        emit(FeeRemarkLoadFail("$e"));
      }
    } else {
      emit(FeeRemarkLoadFail(NO_INTERNET));
    }
  }
}
