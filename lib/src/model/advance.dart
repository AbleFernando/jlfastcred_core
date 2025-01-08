import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'advance.g.dart';

enum AdvanceStatus { emAndamento, finalizado }

@JsonSerializable()
class Advance {
  final String consultantId;
  final String consultantName;
  @JsonKey(
    name: 'dataSolicitacao',
    fromJson: _timestampToDateTime,
    toJson: _dateTimeToTimestamp,
  )
  final DateTime dataSolicitacao;
  final String operationType;
  @JsonKey(
    fromJson: _statusFromJson,
    toJson: _statusToJson,
  )
  final AdvanceStatus status;

  Advance({
    required this.consultantId,
    required this.consultantName,
    required this.dataSolicitacao,
    required this.operationType,
    required this.status,
  });

  static DateTime _timestampToDateTime(Timestamp timestamp) =>
      timestamp.toDate();

  static Timestamp _dateTimeToTimestamp(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);

  static AdvanceStatus _statusFromJson(String status) {
    switch (status) {
      case 'Em andamento':
        return AdvanceStatus.emAndamento;
      case 'Finalizado':
        return AdvanceStatus.finalizado;
      case 'Novo':
      default:
        return AdvanceStatus.emAndamento;
    }
  }

  static String _statusToJson(AdvanceStatus status) {
    switch (status) {
      case AdvanceStatus.emAndamento:
        return 'Em andamento';
      case AdvanceStatus.finalizado:
        return 'Finalizado';
      default:
        return 'Em Andamento';
    }
  }

  factory Advance.fromJson(Map<String, dynamic> json) =>
      _$AdvanceFromJson(json);

  Map<String, dynamic> toJson() => _$AdvanceToJson(this);

  factory Advance.empty() {
    return Advance(
      consultantId: '',
      consultantName: '',
      dataSolicitacao: DateTime.now(),
      operationType: '',
      status: AdvanceStatus.emAndamento,
    );
  }

  bool isEmpty() {
    return consultantId.isEmpty &&
        consultantName.isEmpty &&
        operationType.isEmpty &&
        status == AdvanceStatus.emAndamento;
  }
}
