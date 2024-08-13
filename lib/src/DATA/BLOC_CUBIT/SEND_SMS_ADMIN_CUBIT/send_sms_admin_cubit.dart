import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/sendSmsAdminRepository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';

part 'send_sms_admin_state.dart';

class SendSmsAdminCubit extends Cubit<SendSmsAdminState> {
  final SendSmsAdminRepository repository;
  SendSmsAdminCubit(this.repository) : super(SendSmsAdminInitial());

  Future<void> sendSmsAdminCubitCall(Map<String,String?> request)async{

    if(await isInternetPresent()){
      try{
        emit(SendSmsAdminLoadInProgress());
        final data =await repository.submitSms(request);
        emit(SendSmsAdminLoadSuccess(data));
      }
      catch(e){
        emit(SendSmsAdminLoadFail('$e'));
      }
    }
    else{
      emit(SendSmsAdminLoadFail(NO_INTERNET));
    }
  }
}
