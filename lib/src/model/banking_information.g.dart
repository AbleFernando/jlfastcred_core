// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banking_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankingInformation _$BankingInformationFromJson(Map<String, dynamic> json) =>
    BankingInformation(
      accountNumber: json['account_number'] as String,
      bankName: json['bank_name'] as String,
      branchNumber: json['branch_number'] as String,
      pixKey: json['pix_key'] as String,
      tipoConta: json['tipoConta'] as String? ?? '',
    );

Map<String, dynamic> _$BankingInformationToJson(BankingInformation instance) =>
    <String, dynamic>{
      'account_number': instance.accountNumber,
      'bank_name': instance.bankName,
      'branch_number': instance.branchNumber,
      'pix_key': instance.pixKey,
      'tipoConta': instance.tipoConta,
    };
