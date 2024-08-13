import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/gotoWebAppRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'goto_web_app_state.dart';

class GotoWebAppCubit extends Cubit<GotoWebAppState> {
  final GotoWebAppRepository repository;
  GotoWebAppCubit(this.repository) : super(GotoWebAppInitial());

  Future<void> gotoWebAppCubitCall(Map<String, String?> request) async {
    print("sending gotoWebAppCubitCall $request");
    if (await isInternetPresent()) {
      try {
        emit(GotoWebAppLoadInProgress());
        final data = await repository.gotoWebApp(request);
        print(data);
        emit(GotoWebAppLoadSuccess(data));
      } catch (e) {
        emit(GotoWebAppLoadFail("$e"));
      }
    } else {
      emit(GotoWebAppLoadFail(NO_INTERNET));
    }
  }
}
