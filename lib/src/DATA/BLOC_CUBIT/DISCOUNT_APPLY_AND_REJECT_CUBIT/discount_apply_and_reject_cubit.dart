import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/discountApplyAndRejectRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'discount_apply_and_reject_state.dart';

class DiscountApplyAndRejectCubit extends Cubit<DiscountApplyAndRejectState> {
  final DiscountApplyAndRejectRepository _repository;
  DiscountApplyAndRejectCubit(this._repository) : super(DiscountApplyAndRejectInitial());

  Future<void> discountApplyAndRejectCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(DiscountApplyAndRejectLoadInProgress());
        final data = await _repository.discountApplyAndRejectData(requestPayload);
        emit(DiscountApplyAndRejectLoadSuccess(data));
      } catch (e) {
        emit(DiscountApplyAndRejectLoadFail("$e"));
      }
    } else {
      emit(DiscountApplyAndRejectLoadFail(NO_INTERNET));
    }
  }
}
