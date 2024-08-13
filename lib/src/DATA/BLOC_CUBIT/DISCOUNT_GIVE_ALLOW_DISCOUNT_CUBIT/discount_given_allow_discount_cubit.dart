import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/discountGivenAllowDiscountModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/discountGivenAllowDiscountRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'discount_given_allow_discount_state.dart';

class DiscountGivenAllowDiscountCubit extends Cubit<DiscountGivenAllowDiscountState> {
  final DiscountGivenAllowDiscountRepository _repository;
  DiscountGivenAllowDiscountCubit(this._repository) : super(DiscountGivenAllowDiscountInitial());

  Future<void> discountGivenAllowDiscountCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(DiscountGivenAllowDiscountLoadInProgress());
        final data = await _repository.discountGivenAllowDiscountData(requestPayload);
        emit(DiscountGivenAllowDiscountLoadSuccess(data));
      } catch (e) {
        emit(DiscountGivenAllowDiscountLoadFail("$e"));
      }
    } else {
      emit(DiscountGivenAllowDiscountLoadFail(NO_INTERNET));
    }
  }
}
