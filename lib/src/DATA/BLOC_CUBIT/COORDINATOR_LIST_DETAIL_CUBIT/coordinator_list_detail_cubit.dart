import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/coordinatorListDetailModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/coordinatorListDetailRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'coordinator_list_detail_state.dart';

class CoordinatorListDetailCubit extends Cubit<CoordinatorListDetailState> {
  final CoordinatorListDetailRepository _repository;

  CoordinatorListDetailCubit(this._repository)
      : super(CoordinatorListDetailInitial());

  Future<void> coordinatorListDetailCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(CoordinatorListDetailLoadInProgress());
        var data = await _repository.getCoordinator(request);
        emit(CoordinatorListDetailLoadSuccess(data));
      } catch (e) {
        emit(CoordinatorListDetailLoadFail('$e'));
      }
    } else {
      emit(CoordinatorListDetailLoadFail(NO_INTERNET));
    }
  }
}
