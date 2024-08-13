import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/addNewEmployeeRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'add_new_employee_state.dart';

class AddNewEmployeeCubit extends Cubit<AddNewEmployeeState> {
  final AddNewEmployeeRepository repository;
  AddNewEmployeeCubit(this.repository) : super(AddNewEmployeeInitial());

  Future<void> addNewEmployeeCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(AddNewEmployeeLoadInProgress());
        var data = await repository.addNewEmployee(request);
        emit(AddNewEmployeeLoadSuccess(data));
      } catch (e) {
        emit(AddNewEmployeeLoadFail('$e'));
      }
    } else {
      emit(AddNewEmployeeLoadFail('$NO_INTERNET'));
    }
  }
}
