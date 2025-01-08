// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'banking_information.g.dart';

@JsonSerializable()
class BankingInformation {
  @JsonKey(name: 'account_number')
  final String accountNumber;
  @JsonKey(name: 'bank_name')
  final String bankName;
  @JsonKey(name: 'branch_number')
  final String branchNumber;
  @JsonKey(name: 'pix_key')
  final String pixKey;
  @JsonKey(defaultValue: '')
  final String tipoConta;

  BankingInformation({
    required this.accountNumber,
    required this.bankName,
    required this.branchNumber,
    required this.pixKey,
    required this.tipoConta,
  });

  factory BankingInformation.fromJson(Map<String, dynamic> json) =>
      _$BankingInformationFromJson(json);

  Map<String, dynamic> toJson() => _$BankingInformationToJson(this);

  BankingInformation copyWith({
    String? accountNumber,
    String? bankName,
    String? branchNumber,
    String? pixKey,
    String? tipoConta,
  }) {
    return BankingInformation(
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      branchNumber: branchNumber ?? this.branchNumber,
      pixKey: pixKey ?? this.pixKey,
      tipoConta: tipoConta ?? this.tipoConta,
    );
  }

  factory BankingInformation.empty() {
    return BankingInformation(
      accountNumber: '',
      bankName: '',
      branchNumber: '',
      pixKey: '',
      tipoConta: '',
    );
  }
}
