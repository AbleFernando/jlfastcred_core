// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Advance _$AdvanceFromJson(Map<String, dynamic> json) => Advance(
      consultantId: json['consultantId'] as String,
      consultantName: json['consultantName'] as String,
      dataSolicitacao:
          Advance._timestampToDateTime(json['dataSolicitacao'] as Timestamp),
      operationType: json['operationType'] as String,
      status: Advance._statusFromJson(json['status'] as String),
    );

Map<String, dynamic> _$AdvanceToJson(Advance instance) => <String, dynamic>{
      'consultantId': instance.consultantId,
      'consultantName': instance.consultantName,
      'dataSolicitacao': Advance._dateTimeToTimestamp(instance.dataSolicitacao),
      'operationType': instance.operationType,
      'status': Advance._statusToJson(instance.status),
    };
