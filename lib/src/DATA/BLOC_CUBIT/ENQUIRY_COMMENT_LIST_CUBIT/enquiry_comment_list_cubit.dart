import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/DATA/MODELS/enquiryCommentListModel.dart';
import 'package:campus_pro/src/DATA/MODELS/userTypeModel.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/enquiryCommentListRepository.dart';
import 'package:campus_pro/src/DATA/REPOSITORIES/account_type_repository.dart';
import 'package:campus_pro/src/UTILS/internetCheck.dart';
import 'package:equatable/equatable.dart';
import 'package:campus_pro/src/CONSTANTS/stringConstants.dart';

part 'enquiry_comment_list_state.dart';

class EnquiryCommentListCubit extends Cubit<EnquiryCommentListState> {
  final EnquiryCommentListRepository _repository;

  EnquiryCommentListCubit(this._repository)
      : super(EnquiryCommentListInitial());

  Future<void> enquiryCommentListCubitCall(
      Map<String, String> commentData) async {
    if (await isInternetPresent()) {
      try {
        emit(EnquiryCommentListLoadInProgress());
        final data = await _repository.enquiryCommentList(commentData);
        emit(EnquiryCommentListLoadSuccess(data));
      } catch (e) {
        emit(EnquiryCommentListLoadFail("$e"));
      }
    } else {
      emit(EnquiryCommentListLoadFail(NO_INTERNET));
    }
  }
}
