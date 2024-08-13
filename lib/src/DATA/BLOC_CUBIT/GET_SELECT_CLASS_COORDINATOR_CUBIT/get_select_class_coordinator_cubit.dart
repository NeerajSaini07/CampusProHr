import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getselectClassCoordinatorDropdownModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getselectClassCoordinatorRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_select_class_coordinator_state.dart';

class GetSelectClassCoordinatorCubit
    extends Cubit<GetSelectClassCoordinatorState> {
  final GetSelectClassCoordinatorRepository _repository;
  GetSelectClassCoordinatorCubit(this._repository)
      : super(GetSelectClassCoordinatorInitial());

  Future<void> getSelectClassCoordinatorCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetSelectClassCoordinatorLoadInProgress());
        var data = await _repository.getCoordinatorClass(request);
        emit(GetSelectClassCoordinatorLoadSuccess(data));
      } catch (e) {
        emit(GetSelectClassCoordinatorLoadFail('$e'));
      }
    } else {
      emit(GetSelectClassCoordinatorLoadFail(NO_INTERNET));
    }
  }
}
