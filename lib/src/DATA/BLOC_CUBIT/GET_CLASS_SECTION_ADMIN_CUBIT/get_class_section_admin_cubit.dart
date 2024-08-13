import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getClassSectionAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getClassSectionAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_class_section_admin_state.dart';

class GetClassSectionAdminCubit extends Cubit<GetClassSectionAdminState> {
  final GetClassSectionAdminRepository repository;
  GetClassSectionAdminCubit(this.repository)
      : super(GetClassSectionAdminInitial());

  Future<void> getClassSectionAdminCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetClassSectionAdminLoadInProgress());
        final data = await repository.getSection(request);
        emit(GetClassSectionAdminLoadSuccess(data));
      } catch (e) {
        emit(GetClassSectionAdminLoadFail('$e'));
      }
    } else {
      GetClassSectionAdminLoadFail(NO_INTERNET);
    }
  }
}
