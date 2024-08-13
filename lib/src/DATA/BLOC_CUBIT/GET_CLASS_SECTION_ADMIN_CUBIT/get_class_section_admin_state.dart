part of 'get_class_section_admin_cubit.dart';

abstract class GetClassSectionAdminState extends Equatable {
  const GetClassSectionAdminState();
}

class GetClassSectionAdminInitial extends GetClassSectionAdminState {
  @override
  List<Object> get props => [];
}

class GetClassSectionAdminLoadInProgress extends GetClassSectionAdminState {
  @override
  List<Object> get props => [];
}

class GetClassSectionAdminLoadSuccess extends GetClassSectionAdminState {
  final List<GetClassSectionAdminModel> sectionList;
  GetClassSectionAdminLoadSuccess(this.sectionList);
  @override
  List<Object> get props => [sectionList];
}

class GetClassSectionAdminLoadFail extends GetClassSectionAdminState {
  final String failReason;
  GetClassSectionAdminLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
