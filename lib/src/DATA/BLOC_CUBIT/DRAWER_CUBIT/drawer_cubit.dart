import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../CONSTANTS/stringConstants.dart';
import '../../../UTILS/internetCheck.dart';
import 'package:campus_pro/src/DATA/MODELS/drawerModel.dart';
import '../../REPOSITORIES/drawerRepository.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  //Dependency
  final DrawerRepository _repository;

  DrawerCubit(this._repository) : super(DrawerInitial());

  Future<void> drawerCubitCall(Map<String, String> drawerData, String headerToken) async {
    if (await isInternetPresent()) {
      try {
        emit(DrawerLoadInProgress());
        final data = await _repository.getDrawerItems(drawerData, headerToken);
        emit(DrawerLoadSuccess(data));
      } catch (e) {
        emit(DrawerLoadFail("$e"));
      }
    } else {
      emit(DrawerLoadFail(NO_INTERNET));
    }
  }
}
