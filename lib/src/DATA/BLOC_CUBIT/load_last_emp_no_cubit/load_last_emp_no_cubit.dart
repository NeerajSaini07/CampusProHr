import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/loadLastEmpNoRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'load_last_emp_no_state.dart';

class LoadLastEmpNoCubit extends Cubit<LoadLastEmpNoState> {
  final LoadLastEmpNoRepository repository;
  LoadLastEmpNoCubit(this.repository) : super(LoadLastEmpNoInitial());

  Future<void> loadLastEmpNoCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(LoadLastEmpNoLoadInProgress());
        var data = await repository.loadEmpNo(request);
        emit(LoadLastEmpNoLoadSuccess(data));
      } catch (e) {
        emit(LoadLastEmpNoLoadFail('$e'));
      }
    } else {
      emit(LoadLastEmpNoLoadFail('$NO_INTERNET'));
    }
  }
}
