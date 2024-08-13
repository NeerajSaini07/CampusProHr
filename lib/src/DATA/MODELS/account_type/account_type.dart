import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_type.g.dart';
part 'account_type.freezed.dart';

List<AccountType> accountTypesFromJson(Map<String, dynamic> json) {
  final parsedData = json['Data'];

  List<AccountType> accountTypes = [];
  for(final data in parsedData) {
    accountTypes.add(AccountType.fromJson(data));
  }
  return accountTypes;
}

@freezed
class AccountType with _$AccountType {
  const factory AccountType({
    @JsonKey(name: 'ButtonConfigString') required String buttonConfigString,
    @JsonKey(name: 'CompanyName') required String companyName,
    @JsonKey(name: 'OrganizationId') required String organizationId,
    @JsonKey(name: 'EmpId') required String employId,
    @JsonKey(name: 'CompanyId') required String companyId,
    @JsonKey(name: 'EmpName') required String employName,
    @JsonKey(name: 'OUserType') required String userType,
    @JsonKey(name: 'UserName') required String userName,
    @JsonKey(name: 'Url') required String url,
    @JsonKey(name: 'Flag') required String flag,
    @JsonKey(name: 'LogoImgPath') required String logoImgPath,
    @JsonKey(name: 'CurrentSessionid') required String currentSessionId,
    @JsonKey(name: 'AppUrl') required String appUrl,
}) = _AccountType;

  factory AccountType.fromJson(Map<String, Object?> json) => _$AccountTypeFromJson(json);
}