part of 'download_app_user_data_cubit.dart';

abstract class DownloadAppUserDataState extends Equatable {
  const DownloadAppUserDataState();
}

class DownloadAppUserDataInitial extends DownloadAppUserDataState {
  @override
  List<Object> get props => [];
}

class DownloadAppUserDataLoadInProgress extends DownloadAppUserDataState {
  @override
  List<Object> get props => [];
}

class DownloadAppUserDataLoadSuccess extends DownloadAppUserDataState {
  final List<DownloadAppUserDataModel> downloadData;

  DownloadAppUserDataLoadSuccess(this.downloadData);
  @override
  List<Object> get props => [downloadData];
}

class DownloadAppUserDataLoadFail extends DownloadAppUserDataState {
  final String failReason;

  DownloadAppUserDataLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
