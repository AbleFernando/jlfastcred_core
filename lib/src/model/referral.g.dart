// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Referral _$ReferralFromJson(Map<String, dynamic> json) => Referral(
      id: json['id'] as String? ?? '',
      nome: json['nome'] as String? ?? '',
      contato: json['contato'] as String? ?? '',
      perfil: json['perfil'] as String? ?? '',
    );

Map<String, dynamic> _$ReferralToJson(Referral instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'contato': instance.contato,
      'perfil': instance.perfil,
    };
