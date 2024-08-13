import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadAddressGroupModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/loadAddressGroupRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'load_address_group_state.dart';

class LoadAddressGroupCubit extends Cubit<LoadAddressGroupState> {
  final LoadAddressGroupRepository repository;
  LoadAddressGroupCubit(this.repository) : super(LoadAddressGroupInitial());

  Future<void> loadAddressGroupCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(LoadAddressGroupLoadInProgress());
        final data = await repository.getAddress(request);
        emit(LoadAddressGroupLoadSuccess(data));
      } catch (e) {
        emit(LoadAddressGroupLoadFail('$e'));
      }
    } else {
      emit(LoadAddressGroupLoadFail(NO_INTERNET));
    }
  }
}
