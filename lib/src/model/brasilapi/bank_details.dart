import 'package:json_annotation/json_annotation.dart';

part 'bank_details.g.dart';

@JsonSerializable()
class BankDetails {
  final String ispb;
  @JsonKey(defaultValue: 'Desconhecido')
  final String name;
  @JsonKey(defaultValue: 0)
  final int code;
  @JsonKey(defaultValue: 'Desconhecido')
  final String fullName;

  BankDetails({
    required this.ispb,
    required this.name,
    required this.code,
    required this.fullName,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailsToJson(this);

  factory BankDetails.empty() {
    return BankDetails(
      ispb: '',
      name: '',
      code: 0,
      fullName: '',
    );
  }
}
