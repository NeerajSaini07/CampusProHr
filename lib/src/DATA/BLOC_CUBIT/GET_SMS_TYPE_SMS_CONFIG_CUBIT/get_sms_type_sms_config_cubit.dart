import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/MODELS/getSmsTypeSmsConfigModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/getSmsTypeSmsConfigRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'get_sms_type_sms_config_state.dart';

class GetSmsTypeSmsConfigCubit extends Cubit<GetSmsTypeSmsConfigState> {
  final GetSmsTypeSmsConfigRepository _repository;
  GetSmsTypeSmsConfigCubit(this._repository) : super(GetSmsTypeSmsConfigInitial());

  Future<void> getSmsTypeSmsConfigCubitCall(Map<String,String?> request)async{

    if(await isInternetPresent()){
      try{
        emit(GetSmsTypeSmsConfigStateLoadInProgress());
        var data = await _repository.getSmsType(request);
        emit(GetSmsTypeSmsConfigStateLoadSuccess(data));
      }
      catch(e){
        emit(GetSmsTypeSmsConfigStateLoadFail('$e'));
      }
    }
      else{
        emit(GetSmsTypeSmsConfigStateLoadFail(NO_INTERNET));
    }
  }

}
