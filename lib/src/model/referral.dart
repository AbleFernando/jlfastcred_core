// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'referral.g.dart';

@JsonSerializable()
class Referral {
  @JsonKey(defaultValue: '')
  final String id;
  @JsonKey(defaultValue: '')
  final String nome;
  @JsonKey(defaultValue: '')
  final String contato;
  @JsonKey(defaultValue: '')
  final String perfil;
  Referral({
    required this.id,
    required this.nome,
    required this.contato,
    required this.perfil,
  });

  // Construtor estático para criar uma instância com valores padrão
  factory Referral.empty() {
    return Referral(
      id: '',
      nome: '',
      contato: '',
      perfil: '',
    );
  }

  factory Referral.fromJson(Map<String, dynamic> json) =>
      _$ReferralFromJson(json);

  Map<String, dynamic> toJson() => _$ReferralToJson(this);
}
