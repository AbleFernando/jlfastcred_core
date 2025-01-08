// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      id: json['id'] as String,
      bairro: json['bairro'] as String,
      cep: json['cep'] as String,
      cidade: json['cidade'] as String,
      complemento: json['complemento'] as String,
      contato: json['contato'] as String,
      cpf: json['cpf'] as String,
      email: json['email'] as String,
      endereco: json['endereco'] as String,
      name: json['name'] as String,
      numero: json['numero'] as String,
      perfil: json['perfil'] as String,
      status: json['status'] as String,
      uf: json['uf'] as String,
      dadosBancarios: BankingInformation.fromJson(
          json['dados_bancarios'] as Map<String, dynamic>),
      urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
      isReferral: json['isReferral'] as bool,
      referral: json['referral'] == null
          ? Referral.empty()
          : Referral.fromJson(json['referral'] as Map<String, dynamic>),
      motivoPendencia: json['motivo_pendencia'] as String? ?? '',
      dataCadastro:
          Users._timestampFromJson(json['data_cadastro'] as Timestamp),
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'id': instance.id,
      'bairro': instance.bairro,
      'cep': instance.cep,
      'cidade': instance.cidade,
      'complemento': instance.complemento,
      'contato': instance.contato,
      'cpf': instance.cpf,
      'email': instance.email,
      'endereco': instance.endereco,
      'name': instance.name,
      'numero': instance.numero,
      'perfil': instance.perfil,
      'status': instance.status,
      'uf': instance.uf,
      'dados_bancarios':
          Users._bankingInformationToJson(instance.dadosBancarios),
      'urls': Users._urlToJson(instance.urls),
      'isReferral': instance.isReferral,
      'referral': Users._referralToJson(instance.referral),
      'motivo_pendencia': instance.motivoPendencia,
      'data_cadastro': Users._timestampToJson(instance.dataCadastro),
    };
