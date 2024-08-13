import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/assignAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/assignAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'assign_admin_state.dart';

class AssignAdminCubit extends Cubit<AssignAdminState> {
  //Dependency
  final AssignAdminRepository _repository;

  AssignAdminCubit(this._repository) : super(AssignAdminInitial());

  Future<void> assignAdminCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(AssignAdminLoadInProgress());
        final data = await _repository.assign(request);
        emit(AssignAdminLoadSuccess(data));
      } catch (e) {
        emit(AssignAdminLoadFail("$e"));
      }
    } else {
      emit(AssignAdminLoadFail(NO_INTERNET));
    }
  }
}
