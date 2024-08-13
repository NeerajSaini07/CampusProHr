import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getComplainSuggestionListAdminModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getComplainSuggestionListAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_complain_suggestion_list_admin_state.dart';

class GetComplainSuggestionListAdminCubit
    extends Cubit<GetComplainSuggestionListAdminState> {
  final GetComplainSuggestionListAdminRepository repository;

  GetComplainSuggestionListAdminCubit(this.repository)
      : super(GetComplainSuggestionListAdminInitial());

  Future<void> getComplainSuggestionListAdminCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(GetComplainSuggestionListAdminLoadInProgress());
        final data = await repository.getSuggestionList(request);
        emit(GetComplainSuggestionListAdminLoadSuccess(data));
      } catch (e) {
        emit(GetComplainSuggestionListAdminLoadFail('$e'));
      }
    } else {
      emit(GetComplainSuggestionListAdminLoadFail(NO_INTERNET));
    }
  }
}
