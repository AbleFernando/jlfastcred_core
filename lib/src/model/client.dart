// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:jlfastcred_core/jlfastcred_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  final String id;
  final String bairro;
  final String cep;
  final String cidade;
  final String complemento;
  final String cpfOrBenefitNumber;
  // final Timestamp dataCadastro;
  final String email;
  final String contato;
  final String endereco;
  final String name;
  final String numero;
  final String uf;
  @JsonKey(name: 'dados_bancarios', toJson: _bankingInformationToJson)
  final BankingInformation dadosBancarios;
  @JsonKey(toJson: _urlToJson)
  final Urls urls;
  final bool isClient;
  // final String consultantId;

  Client({
    required this.id,
    required this.bairro,
    required this.cep,
    required this.cidade,
    required this.complemento,
    required this.cpfOrBenefitNumber,
    required this.email,
    required this.contato,
    required this.endereco,
    required this.name,
    required this.numero,
    required this.uf,
    required this.dadosBancarios,
    required this.urls,
    required this.isClient,
    // required this.consultantId,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

  static Map<String, dynamic> _bankingInformationToJson(
          BankingInformation instance) =>
      instance.toJson();

  static Map<String, dynamic> _urlToJson(Urls instance) => instance.toJson();

  // Construtor estático para criar uma instância com valores padrão
  factory Client.empty() {
    return Client(
      id: '',
      bairro: '',
      cep: '',
      cidade: '',
      complemento: '',
      cpfOrBenefitNumber: '',
      email: '',
      contato: '',
      endereco: '',
      name: '',
      numero: '',
      uf: '',
      dadosBancarios: BankingInformation.empty(),
      urls: Urls.empty(),
      isClient: false,
      // consultantId: '',
    );
  }

  Client copyWith({
    String? id,
    String? bairro,
    String? cep,
    String? cidade,
    String? complemento,
    String? cpfOrBenefitNumber,
    String? email,
    String? contato,
    String? endereco,
    String? name,
    String? numero,
    String? uf,
    BankingInformation? dadosBancarios,
    Urls? urls,
    bool? isCliente,
    // String? consultantId,
  }) {
    return Client(
        id: id ?? this.id,
        bairro: bairro ?? this.bairro,
        cep: cep ?? this.cep,
        cidade: cidade ?? this.cidade,
        complemento: complemento ?? this.complemento,
        cpfOrBenefitNumber: cpfOrBenefitNumber ?? this.cpfOrBenefitNumber,
        email: email ?? this.email,
        contato: contato ?? this.contato,
        endereco: endereco ?? this.endereco,
        name: name ?? this.name,
        numero: numero ?? this.numero,
        uf: uf ?? this.uf,
        dadosBancarios: dadosBancarios ?? this.dadosBancarios,
        urls: urls ?? this.urls,
        isClient: isClient
        // consultantId: consultantId ?? this.consultantId,
        );
  }
}
