import 'package:bloc/bloc.dart';
import 'package:campus_pro/src/DATA/MODELS/teachersListModel.dart';
import 'package:equatable/equatable.dart';

part 'class_end_drawer_local_state.dart';

class ClassEndDrawerLocalCubit extends Cubit<ClassEndDrawerLocalState> {
  ClassEndDrawerLocalCubit() : super(ClassEndDrawerLocalInitial());

  Future<void> classEndDrawerLocalCubitCall(
      TeachersListModel teacherData) async {
    emit(ClassEndDrawerLocalLoadInProgress());
    Future.delayed(Duration(milliseconds: 300));
    emit(ClassEndDrawerLocalLoadSuccess(teacherData));
  }
}
