// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'cep_v1.g.dart';

@JsonSerializable()
class CepV1 {
  final String cep;
  final String state;
  final String city;
  final String neighborhood;
  final String street;
  final String service;

  CepV1({
    required this.cep,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.street,
    required this.service,
  });

  factory CepV1.fromJson(Map<String, dynamic> json) => _$CepV1FromJson(json);

  Map<String, dynamic> toJson() => _$CepV1ToJson(this);

  factory CepV1.empty() {
    return CepV1(
      cep: '',
      state: '',
      city: '',
      neighborhood: '',
      street: '',
      service: '',
    );
  }

  CepV1 copyWith({
    String? cep,
    String? state,
    String? city,
    String? neighborhood,
    String? street,
    String? service,
  }) {
    return CepV1(
      cep: cep ?? this.cep,
      state: state ?? this.state,
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      street: street ?? this.street,
      service: service ?? this.service,
    );
  }
}
