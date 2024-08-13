import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/PAYMENT_GATEWAY_MODELS/ebsHashModel.dart';
import 'package:campus_pro/src/DATA/MODELS/activityModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/PAYMENT_GATEWAY_REPOSITORY/ebsHashRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/activityRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'ebs_hash_state.dart';

class EbsHashCubit extends Cubit<EbsHashState> {
  final EbsHashRepository _repository;
  EbsHashCubit(this._repository) : super(EbsHashInitial());

  Future<void> ebsHashCubitCall(Map<String, String?> sendData) async {
    if (await isInternetPresent()) {
      try {
        emit(EbsHashLoadInProgress());
        final data = await _repository.ebsHash(sendData);
        emit(EbsHashLoadSuccess(data));
      } catch (e) {
        emit(EbsHashLoadFail("$e"));
      }
    } else {
      emit(EbsHashLoadFail(NO_INTERNET));
    }
  }
}
