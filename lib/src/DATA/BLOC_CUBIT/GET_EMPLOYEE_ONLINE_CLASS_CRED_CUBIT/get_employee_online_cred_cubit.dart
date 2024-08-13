import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getEmployeeOnlineClassCredentialsRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_employee_online_cred_state.dart';

class GetEmployeeOnlineCredCubit extends Cubit<GetEmployeeOnlineCredState> {
  final GetEmployeeOnlineClassCredentialsRepository repository;
  GetEmployeeOnlineCredCubit(this.repository)
      : super(GetEmployeeOnlineCredInitial());

  Future<void> getEmployeeOnlineCredCubitCall(
      Map<String, String?> request, String mode) async {
    if (await isInternetPresent()) {
      try {
        emit(GetEmployeeOnlineCredLoadInProgress());
        var data = await repository.getValues(request, mode);
        emit(GetEmployeeOnlineCredLoadSuccess(data));
      } catch (e) {
        emit(GetEmployeeOnlineCredLoadFail('$e'));
      }
    } else {
      emit(GetEmployeeOnlineCredLoadFail(NO_INTERNET));
    }
  }
}
