import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getExamResultPublishModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getExamResultPublishRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_exam_result_publish_state.dart';

class GetExamResultPublishCubit extends Cubit<GetExamResultPublishState> {
  final GetExamResultPublishRepository repository;
  GetExamResultPublishCubit(this.repository)
      : super(GetExamResultPublishInitial());

  Future<void> getExamResultPublishCubitCall(
      Map<String, dynamic> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetExamResultPublishLoadInProgress());
        var data = await repository.getStudentList(request);
        emit(GetExamResultPublishLoadSuccess(data));
      } catch (e) {
        emit(GetExamResultPublishLoadFail('$e'));
      }
    } else {
      emit(GetExamResultPublishLoadFail(NO_INTERNET));
    }
  }
}
