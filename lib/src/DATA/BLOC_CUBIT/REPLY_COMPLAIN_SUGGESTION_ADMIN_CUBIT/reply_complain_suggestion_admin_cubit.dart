import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/replyComplainSuggestionAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'reply_complain_suggestion_admin_state.dart';

class ReplyComplainSuggestionAdminCubit
    extends Cubit<ReplyComplainSuggestionAdminState> {
  final ReplyComplainSuggestionAdminRepository repository;
  ReplyComplainSuggestionAdminCubit(this.repository)
      : super(ReplyComplainSuggestionAdminInitial());

  Future<void> replyComplainSuggestionAdminCubitCall(
      Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(ReplyComplainSuggestionAdminLoadInProgress());
        final result = await repository.replySuggestion(request);
        emit(ReplyComplainSuggestionAdminLoadSuccess(result));
      } catch (e) {
        emit(ReplyComplainSuggestionAdminLoadFail('$e'));
      }
    } else {
      emit(ReplyComplainSuggestionAdminLoadFail(NO_INTERNET));
    }
  }
}
