import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/fetchClientSecretIdModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/fetchClientSecretIdRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'fetch_client_secret_id_state.dart';

class FetchClientSecretIdCubit extends Cubit<FetchClientSecretIdState> {
  final FetchClientSecretIdRepository _repository;
  FetchClientSecretIdCubit(this._repository)
      : super(FetchClientSecretIdInitial());

  Future<void> fetchClientSecretIdCubitCall(
      Map<String, String?> clientData) async {
    if (await isInternetPresent()) {
      try {
        emit(FetchClientSecretIdLoadInProgress());
        final data = await _repository.fetchIDs(clientData);
        emit(FetchClientSecretIdLoadSuccess(data));
      } catch (e) {
        emit(FetchClientSecretIdLoadFail("$e"));
      }
    } else {
      emit(FetchClientSecretIdLoadFail(NO_INTERNET));
    }
  }
}
