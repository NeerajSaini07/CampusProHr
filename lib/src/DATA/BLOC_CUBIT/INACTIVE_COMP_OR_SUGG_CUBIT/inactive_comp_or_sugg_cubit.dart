import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/inactiveCompOrSuggRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'inactive_comp_or_sugg_state.dart';

class InactiveCompOrSuggCubit extends Cubit<InactiveCompOrSuggState> {
  final InactiveCompOrSuggRepository repository;
  InactiveCompOrSuggCubit(this.repository) : super(InactiveCompOrSuggInitial());

  Future<void> inactiveCompOrSuggCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(InactiveCompOrSuggLoadInProgress());
        final result = await repository.inActiveSuggestion(request);
        emit(InactiveCompOrSuggLoadSuccess(result));
      } catch (e) {
        emit(InactiveCompOrSuggLoadFail('$e'));
      }
    } else {
      emit(InactiveCompOrSuggLoadFail(NO_INTERNET));
    }
  }
}
