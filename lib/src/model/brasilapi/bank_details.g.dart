// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetails _$BankDetailsFromJson(Map<String, dynamic> json) => BankDetails(
      ispb: json['ispb'] as String,
      name: json['name'] as String? ?? 'Desconhecido',
      code: json['code'] as int? ?? 0,
      fullName: json['fullName'] as String? ?? 'Desconhecido',
    );

Map<String, dynamic> _$BankDetailsToJson(BankDetails instance) =>
    <String, dynamic>{
      'ispb': instance.ispb,
      'name': instance.name,
      'code': instance.code,
      'fullName': instance.fullName,
    };
