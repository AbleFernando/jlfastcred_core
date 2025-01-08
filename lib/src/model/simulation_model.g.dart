// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimulationModel _$SimulationModelFromJson(Map<String, dynamic> json) =>
    SimulationModel(
      id: json['id'] as String,
      banco: json['banco'] as String? ?? '',
      birthDate:
          SimulationModel._timestampToDateTime(json['birthDate'] as Timestamp),
      cpfOrBenefitNumber: json['cpfOrBenefitNumber'] as String,
      dataDigitacao: json['dataDigitacao'] as String? ?? '',
      dataCadastro: SimulationModel._timestampToDateTime(
          json['data_cadastro'] as Timestamp),
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      link: json['link'] as String? ?? '',
      name: json['name'] as String,
      numeroProposta: json['numeroProposta'] as String? ?? '',
      operationType: json['operationType'] as String,
      status: json['status'] as String,
      statusDigitacao: json['statusDigitacao'] as String? ?? '',
      comissao: (json['comissao'] as num?)?.toDouble() ?? 0.0,
      pontosFastCred: (json['pontosFastCred'] as num?)?.toDouble() ?? 0.0,
      consultant: Users.fromJson(json['consultant'] as Map<String, dynamic>),
      motivoPendencia: json['motivo_pendencia'] as String? ?? '',
      tipoContrato: json['tipo_contrato'] as String? ?? '',
      client: Client.fromJson(json['client'] as Map<String, dynamic>),
      margemUrl: json['margemUrl'] as String,
    );

Map<String, dynamic> _$SimulationModelToJson(SimulationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'banco': instance.banco,
      'birthDate': SimulationModel._dateTimeToTimestamp(instance.birthDate),
      'cpfOrBenefitNumber': instance.cpfOrBenefitNumber,
      'dataDigitacao': instance.dataDigitacao,
      'data_cadastro':
          SimulationModel._dateTimeToTimestamp(instance.dataCadastro),
      'imageUrls': instance.imageUrls,
      'link': instance.link,
      'name': instance.name,
      'numeroProposta': instance.numeroProposta,
      'operationType': instance.operationType,
      'status': instance.status,
      'statusDigitacao': instance.statusDigitacao,
      'comissao': instance.comissao,
      'pontosFastCred': instance.pontosFastCred,
      'consultant': SimulationModel._usersToJson(instance.consultant),
      'motivo_pendencia': instance.motivoPendencia,
      'tipo_contrato': instance.tipoContrato,
      'client': SimulationModel._clientsToJson(instance.client),
      'margemUrl': instance.margemUrl,
    };
