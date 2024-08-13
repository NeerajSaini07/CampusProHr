import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/feeCollectionsClassWiseModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/feeCollectionsClassWiseRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fee_collections_class_wise_state.dart';

class FeeCollectionsClassWiseCubit extends Cubit<FeeCollectionsClassWiseState> {
  final FeeCollectionsClassWiseRepository _repository;
  FeeCollectionsClassWiseCubit(this._repository) : super(FeeCollectionsClassWiseInitial());

  Future<void> feeCollectionsClassWiseCubitCall(
      Map<String, String?> requestPayload) async {
    if (await isInternetPresent()) {
      try {
        emit(FeeCollectionsClassWiseLoadInProgress());
        final data = await _repository.feeCollectionsClassWiseData(requestPayload);
        emit(FeeCollectionsClassWiseLoadSuccess(data));
      } catch (e) {
        emit(FeeCollectionsClassWiseLoadFail("$e"));
      }
    } else {
      emit(FeeCollectionsClassWiseLoadFail(NO_INTERNET));
    }
  }
}
