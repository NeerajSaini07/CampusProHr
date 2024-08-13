import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getUserAssignMenuModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getUserAssignMenuRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_user_assign_menu_state.dart';

class GetUserAssignMenuCubit extends Cubit<GetUserAssignMenuState> {
  final GetUserAssignMenuRepository _repository;
  GetUserAssignMenuCubit(this._repository) : super(GetUserAssignMenuInitial());

  Future<void> getUserAssignMenuCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetUserAssignMenuLoadInProgress());
        final data = await _repository.getAssignMenu(request);
        emit(GetUserAssignMenuLoadSuccess(data));
      } catch (e) {
        emit(GetUserAssignMenuLoadFail('$e'));
      }
    } else {
      emit(GetUserAssignMenuLoadFail('$NO_INTERNET'));
    }
  }
}
