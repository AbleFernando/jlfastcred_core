// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: json['id'] as String,
      bairro: json['bairro'] as String,
      cep: json['cep'] as String,
      cidade: json['cidade'] as String,
      complemento: json['complemento'] as String,
      cpfOrBenefitNumber: json['cpfOrBenefitNumber'] as String,
      email: json['email'] as String,
      contato: json['contato'] as String,
      endereco: json['endereco'] as String,
      name: json['name'] as String,
      numero: json['numero'] as String,
      uf: json['uf'] as String,
      dadosBancarios: BankingInformation.fromJson(
          json['dados_bancarios'] as Map<String, dynamic>),
      urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
      isClient: json['isClient'] as bool,
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'bairro': instance.bairro,
      'cep': instance.cep,
      'cidade': instance.cidade,
      'complemento': instance.complemento,
      'cpfOrBenefitNumber': instance.cpfOrBenefitNumber,
      'email': instance.email,
      'contato': instance.contato,
      'endereco': instance.endereco,
      'name': instance.name,
      'numero': instance.numero,
      'uf': instance.uf,
      'dados_bancarios':
          Client._bankingInformationToJson(instance.dadosBancarios),
      'urls': Client._urlToJson(instance.urls),
      'isClient': instance.isClient,
    };
