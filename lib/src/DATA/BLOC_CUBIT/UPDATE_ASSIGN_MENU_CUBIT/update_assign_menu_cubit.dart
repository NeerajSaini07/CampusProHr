import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/updateAssignMenuRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'update_assign_menu_state.dart';

class UpdateAssignMenuCubit extends Cubit<UpdateAssignMenuState> {
  final UpdateAssignMenuRepository repository;
  UpdateAssignMenuCubit(this.repository) : super(UpdateAssignMenuInitial());

  Future<void> updateAssignMenuCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(UpdateAssignMenuLoadInProgress());
        final data = await repository.updateMenu(request);
        emit(UpdateAssignMenuLoadSuccess(data));
      } catch (e) {
        emit(UpdateAssignMenuLoadFail('$e'));
      }
    } else {
      emit(UpdateAssignMenuLoadFail(NO_INTERNET));
    }
  }
}
