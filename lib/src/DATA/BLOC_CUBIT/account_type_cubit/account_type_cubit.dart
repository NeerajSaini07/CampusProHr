import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/DATA/MODELS/models.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/account_type_repository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

part 'account_type_state.dart';

class AccountTypeCubit extends Cubit<AccountTypeState> {
  final AccountTypeRepository _repository;

  AccountTypeCubit(this._repository) : super(AccountTypeInitial());

  Future<void> accountTypeCubitCall(Map<String, String> accountTypeData) async {
    if (await isInternetPresent()) {
      try {
        emit(AccountTypeLoadInProgress());
        final data = await _repository.getUserType(accountTypeData);
        emit(AccountTypeLoadSuccess(data));
      } catch (e) {
        emit(AccountTypeLoadFail("$e"));
      }
    } else {
      emit(AccountTypeLoadFail(NO_INTERNET));
    }
  }
}
