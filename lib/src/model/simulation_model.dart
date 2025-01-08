// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:jlfastcred_core/src/model/client.dart';
import 'package:jlfastcred_core/src/model/users.dart';

// import 'users.dart';

part 'simulation_model.g.dart';

enum SimulationStatus { nova, devolvida, aprovada, rejeitada }

enum DigitacaoStatus {
  aguardandoCadastroCliente,
  aguardandoDigitacao,
  reprovada,
  paga
}

// Um model representa a estrutura de dados da aplicação.
// Ele define os objetos e suas propriedades que são usados para transferir
// dados entre as diferentes camadas da aplicação.
@JsonSerializable()
class SimulationModel {
  final String id;
  @JsonKey(defaultValue: '')
  final String banco;
  @JsonKey(fromJson: _timestampToDateTime, toJson: _dateTimeToTimestamp)
  final DateTime birthDate;
  final String cpfOrBenefitNumber;
  @JsonKey(defaultValue: '')
  final String dataDigitacao;
  @JsonKey(
    name: 'data_cadastro',
    fromJson: _timestampToDateTime,
    toJson: _dateTimeToTimestamp,
  )
  final DateTime dataCadastro;
  final List<String> imageUrls;
  @JsonKey(defaultValue: '')
  final String link;
  final String name;
  @JsonKey(defaultValue: '')
  final String numeroProposta;
  final String operationType;
  final String status;
  @JsonKey(defaultValue: '')
  final String statusDigitacao;
  @JsonKey(defaultValue: 0.00)
  final double comissao;
  @JsonKey(defaultValue: 0.00)
  final double pontosFastCred;
  @JsonKey(toJson: _usersToJson)
  final Users consultant;
  @JsonKey(name: 'motivo_pendencia', defaultValue: '')
  final String motivoPendencia;
  @JsonKey(name: 'tipo_contrato', defaultValue: '')
  final String tipoContrato;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? file;
  @JsonKey(toJson: _clientsToJson)
  final Client client;
  final String margemUrl;

  SimulationModel(
      {required this.id,
      required this.banco,
      required this.birthDate,
      required this.cpfOrBenefitNumber,
      required this.dataDigitacao,
      required this.dataCadastro,
      this.imageUrls = const [],
      required this.link,
      required this.name,
      required this.numeroProposta,
      required this.operationType,
      required this.status,
      required this.statusDigitacao,
      required this.comissao,
      required this.pontosFastCred,
      required this.consultant,
      required this.motivoPendencia,
      required this.tipoContrato,
      this.file,
      required this.client,
      required this.margemUrl});

  factory SimulationModel.fromJson(Map<String, dynamic> json) =>
      _$SimulationModelFromJson(json);

  Map<String, dynamic> toJson() => _$SimulationModelToJson(this);

  static DateTime _timestampToDateTime(Timestamp timestamp) =>
      timestamp.toDate();

  static Timestamp _dateTimeToTimestamp(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);

  static Map<String, dynamic> _usersToJson(Users instance) => instance.toJson();

  static Map<String, dynamic> _clientsToJson(Client instance) =>
      instance.toJson();

  SimulationModel copyWith(
      {String? id,
      String? banco,
      DateTime? birthDate,
      String? cpfOrBenefitNumber,
      String? dataDigitacao,
      DateTime? dataCadastro,
      List<String>? imageUrls,
      String? link,
      String? name,
      String? numeroProposta,
      String? operationType,
      String? status,
      String? statusDigitacao,
      double? comissao,
      double? pontosFastCred,
      Users? consultant,
      String? motivoPendencia,
      String? tipoContrato,
      File? file,
      Client? client,
      String? margemUrl}) {
    return SimulationModel(
      id: id ?? this.id,
      banco: banco ?? this.banco,
      birthDate: birthDate ?? this.birthDate,
      cpfOrBenefitNumber: cpfOrBenefitNumber ?? this.cpfOrBenefitNumber,
      dataDigitacao: dataDigitacao ?? this.dataDigitacao,
      dataCadastro: dataCadastro ?? this.dataCadastro,
      imageUrls: imageUrls ?? this.imageUrls,
      link: link ?? this.link,
      name: name ?? this.name,
      numeroProposta: numeroProposta ?? this.numeroProposta,
      operationType: operationType ?? this.operationType,
      status: status ?? this.status,
      statusDigitacao: statusDigitacao ?? this.statusDigitacao,
      comissao: comissao ?? this.comissao,
      pontosFastCred: pontosFastCred ?? this.pontosFastCred,
      consultant: consultant ?? this.consultant,
      motivoPendencia: motivoPendencia ?? this.motivoPendencia,
      tipoContrato: tipoContrato ?? this.tipoContrato,
      file: file ?? this.file,
      client: client ?? this.client,
      margemUrl: margemUrl ?? this.margemUrl,
    );
  }
}
