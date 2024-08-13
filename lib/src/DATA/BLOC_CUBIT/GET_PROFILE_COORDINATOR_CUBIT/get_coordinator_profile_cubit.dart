import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getCoordinatorProfileModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getCoordinatorProfileRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_coordinator_profile_state.dart';

class GetCoordinatorProfileCubit extends Cubit<GetCoordinatorProfileState> {
  final GetCoordinatorProfileRepository _repository;
  GetCoordinatorProfileCubit(this._repository)
      : super(GetCoordinatorProfileInitial());

  Future<void> getCoordinatorProfileCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetCoordinatorProfileLoadInProgress());
        var data = await _repository.getProfile(request);
        emit(GetCoordinatorProfileLoadSuccess(data));
      } catch (e) {
        emit(GetCoordinatorProfileLoadFail('$e'));
      }
    } else {
      emit(GetCoordinatorProfileLoadFail(NO_INTERNET));
    }
  }
}
