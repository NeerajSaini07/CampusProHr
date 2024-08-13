part of 'admission_status_cubit.dart';

abstract class AdmissionStatusState extends Equatable {
  const AdmissionStatusState();
}

class AdmissionStatusInitial extends AdmissionStatusState {
  @override
  List<Object> get props => [];
}

class AdmissionStatusLoadInProgress extends AdmissionStatusState {
  @override
  List<Object> get props => [];
}

class AdmissionStatusLoadSuccess extends AdmissionStatusState {
  final AdmissionStatusModel admissionStatus;

  AdmissionStatusLoadSuccess(this.admissionStatus);
  @override
  List<Object> get props => [admissionStatus];
}

class AdmissionStatusLoadFail extends AdmissionStatusState {
  final String failReason;

  AdmissionStatusLoadFail(this.failReason);
  @override
  List<Object> get props => [failReason];
}
