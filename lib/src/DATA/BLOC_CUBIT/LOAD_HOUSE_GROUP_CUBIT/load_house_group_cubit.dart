import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/loadHouseGroupModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/loadHouseGroupRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'load_house_group_state.dart';

class LoadHouseGroupCubit extends Cubit<LoadHouseGroupState> {
  final LoadHouseGroupRepository repository;
  LoadHouseGroupCubit(this.repository) : super(LoadHouseGroupInitial());

  Future<void> loadHouseGroupCubitCall(Map<String, String?> request) async {
    if (await isInternetPresent()) {
      try {
        emit(LoadHouseGroupLoadInProgress());
        final data = await repository.getHouses(request);
        emit(LoadHouseGroupLoadSuccess(data));
      } catch (e) {
        emit(LoadHouseGroupLoadFail("$e"));
      }
    } else {
      emit(LoadHouseGroupLoadFail(NO_INTERNET));
    }
  }
}
