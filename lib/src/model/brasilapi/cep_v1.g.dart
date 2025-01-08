// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cep_v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CepV1 _$CepV1FromJson(Map<String, dynamic> json) => CepV1(
      cep: json['cep'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      neighborhood: json['neighborhood'] as String,
      street: json['street'] as String,
      service: json['service'] as String,
    );

Map<String, dynamic> _$CepV1ToJson(CepV1 instance) => <String, dynamic>{
      'cep': instance.cep,
      'state': instance.state,
      'city': instance.city,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
      'service': instance.service,
    };
