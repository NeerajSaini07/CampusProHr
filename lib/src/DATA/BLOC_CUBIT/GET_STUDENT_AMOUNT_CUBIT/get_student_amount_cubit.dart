import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getStudentMonthlyAmountRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_student_amount_state.dart';

class GetStudentAmountCubit extends Cubit<GetStudentAmountState> {
  final GetStudentMonthlyAmountRepository repository;
  GetStudentAmountCubit(this.repository) : super(GetStudentAmountInitial());

  Future<void> getStudentAmountCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetStudentAmountLoadInProgress());
        var data = await repository.getAmount(request);
        emit(GetStudentAmountLoadSuccess(data));
      } catch (e) {
        emit(GetStudentAmountLoadFail('$e'));
      }
    } else {
      emit(GetStudentAmountLoadFail(NO_INTERNET));
    }
  }
}
