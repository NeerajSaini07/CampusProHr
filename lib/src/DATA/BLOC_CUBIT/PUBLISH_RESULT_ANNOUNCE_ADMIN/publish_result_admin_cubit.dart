import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/publishResultAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'publish_result_admin_state.dart';

class PublishResultAdminCubit extends Cubit<PublishResultAdminState> {
  final PublishResultAdminRepository repository;
  PublishResultAdminCubit(this.repository) : super(PublishResultAdminInitial());

  Future<void> publishResultAdminCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(PublishResultAdminLoadInProgress());
        final data = await repository.getResultPublish(request);
        emit(PublishResultAdminLoadSuccess(data));
      } catch (e) {
        emit(PublishResultAdminLoadFail('$e'));
      }
    } else {
      emit(PublishResultAdminLoadFail(NO_INTERNET));
    }
  }
}
