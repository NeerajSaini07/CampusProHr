// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountTypeImpl _$$AccountTypeImplFromJson(Map<String, dynamic> json) =>
    _$AccountTypeImpl(
      buttonConfigString: json['ButtonConfigString'] as String,
      companyName: json['CompanyName'] as String,
      organizationId: json['OrganizationId'] as String,
      employId: json['EmpId'] as String,
      companyId: json['CompanyId'] as String,
      employName: json['EmpName'] as String,
      userType: json['OUserType'] as String,
      userName: json['UserName'] as String,
      url: json['Url'] as String,
      flag: json['Flag'] as String,
      logoImgPath: json['LogoImgPath'] as String,
      currentSessionId: json['CurrentSessionid'] as String,
      appUrl: json['AppUrl'] as String,
    );

Map<String, dynamic> _$$AccountTypeImplToJson(_$AccountTypeImpl instance) =>
    <String, dynamic>{
      'ButtonConfigString': instance.buttonConfigString,
      'CompanyName': instance.companyName,
      'OrganizationId': instance.organizationId,
      'EmpId': instance.employId,
      'CompanyId': instance.companyId,
      'EmpName': instance.employName,
      'OUserType': instance.userType,
      'UserName': instance.userName,
      'Url': instance.url,
      'Flag': instance.flag,
      'LogoImgPath': instance.logoImgPath,
      'CurrentSessionid': instance.currentSessionId,
      'AppUrl': instance.appUrl,
    };
