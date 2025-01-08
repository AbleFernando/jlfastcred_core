// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'urls.g.dart';

@JsonSerializable()
class Urls {
  final String frontDocumentUrl;
  final String backDocumentUrl;
  final String selfieUrl;
  final String criminalRecordUrl;
  Urls({
    required this.frontDocumentUrl,
    required this.backDocumentUrl,
    required this.selfieUrl,
    required this.criminalRecordUrl,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsToJson(this);

  factory Urls.empty() {
    return Urls(
      frontDocumentUrl: '',
      backDocumentUrl: '',
      selfieUrl: '',
      criminalRecordUrl: '',
    );
  }
}
