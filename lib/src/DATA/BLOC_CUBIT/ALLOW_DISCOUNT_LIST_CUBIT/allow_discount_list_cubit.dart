import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/allowDiscountListModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/allowDiscountListRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'allow_discount_list_state.dart';

class AllowDiscountListCubit extends Cubit<AllowDiscountListState> {
  final AllowDiscountListRepository _repository;
  AllowDiscountListCubit(this._repository) : super(AllowDiscountListInitial());

  Future<void> allowDiscountListCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(AllowDiscountListLoadInProgress());
        final data = await _repository.allowDiscountListData(requestPayload);
        emit(AllowDiscountListLoadSuccess(data));
      } catch (e) {
        emit(AllowDiscountListLoadFail("$e"));
      }
    } else {
      emit(AllowDiscountListLoadFail(NO_INTERNET));
    }
  }
}
