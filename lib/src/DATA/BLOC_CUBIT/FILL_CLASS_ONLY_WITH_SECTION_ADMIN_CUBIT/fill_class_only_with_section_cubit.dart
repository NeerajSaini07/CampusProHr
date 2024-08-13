import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/fillClassOnlyWithSectionAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/fillClassOnlyWithSectionAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fill_class_only_with_section_state.dart';

class FillClassOnlyWithSectionCubit
    extends Cubit<FillClassOnlyWithSectionState> {
  final FillClassOnlyWithSectionAdminRepository repository;
  FillClassOnlyWithSectionCubit(this.repository)
      : super(FillClassOnlyWithSectionInitial());

  Future<void> fillClassOnlyWithSectionCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(FillClassOnlyWithSectionLoadInProgress());
        final data = await repository.getClass(request);
        emit(FillClassOnlyWithSectionLoadSuccess(data));
      } catch (e) {
        emit(FillClassOnlyWithSectionLoadFail('$e'));
      }
    } else {
      emit(FillClassOnlyWithSectionLoadFail(NO_INTERNET));
    }
  }
}
