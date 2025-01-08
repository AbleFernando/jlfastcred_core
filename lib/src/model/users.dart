import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'banking_information.dart';
import 'referral.dart';
import 'urls.dart';

part 'users.g.dart';

enum UsersStatus {
  cadastrando,
  novo,
  reprovado,
  devolvido,
}

enum UsersPerfil {
  administrador,
  consultor,
}

@JsonSerializable()
class Users {
  String id;
  String bairro;
  String cep;
  String cidade;
  String complemento;
  String contato;
  String cpf;
  String email;
  String endereco;
  String name;
  String numero;
  String perfil;
  String status;
  String uf;
  @JsonKey(name: 'dados_bancarios', toJson: _bankingInformationToJson)
  BankingInformation dadosBancarios;
  @JsonKey(toJson: _urlToJson)
  Urls urls;
  bool isReferral;
  @JsonKey(defaultValue: Referral.empty, toJson: _referralToJson)
  Referral referral;
  @JsonKey(name: 'motivo_pendencia', defaultValue: '')
  String motivoPendencia;
  @JsonKey(
      name: 'data_cadastro',
      fromJson: _timestampFromJson,
      toJson: _timestampToJson)
  @TimestampConverter()
  Timestamp dataCadastro;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? passWord;
  Users({
    required this.id,
    required this.bairro,
    required this.cep,
    required this.cidade,
    required this.complemento,
    required this.contato,
    required this.cpf,
    required this.email,
    required this.endereco,
    required this.name,
    required this.numero,
    required this.perfil,
    required this.status,
    required this.uf,
    required this.dadosBancarios,
    required this.urls,
    required this.isReferral,
    required this.referral,
    required this.motivoPendencia,
    required this.dataCadastro,
    this.passWord,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);

  static Map<String, dynamic> _bankingInformationToJson(
          BankingInformation instance) =>
      instance.toJson();

  static Map<String, dynamic> _referralToJson(Referral instance) =>
      instance.toJson();

  static Map<String, dynamic> _urlToJson(Urls instance) => instance.toJson();

  static Timestamp _timestampFromJson(Timestamp timestamp) => timestamp;
  static Timestamp _timestampToJson(Timestamp timestamp) => timestamp;

  factory Users.empty() {
    return Users(
        id: '',
        bairro: '',
        cep: '',
        cidade: '',
        complemento: '',
        contato: '',
        cpf: '',
        email: '',
        endereco: '',
        name: '',
        numero: '',
        perfil: '',
        status: '',
        uf: '',
        dadosBancarios: BankingInformation.empty(),
        urls: Urls.empty(),
        isReferral: false,
        referral: Referral.empty(),
        motivoPendencia: '',
        dataCadastro: Timestamp.now());
  }

  Users copyWith(
      {String? id,
      String? bairro,
      String? cep,
      String? cidade,
      String? complemento,
      String? contato,
      String? cpf,
      String? email,
      String? endereco,
      String? name,
      String? numero,
      String? perfil,
      String? status,
      String? uf,
      BankingInformation? dadosBancarios,
      Urls? urls,
      bool? isReferral,
      Referral? referral,
      String? motivoPendencia,
      String? password}) {
    return Users(
        id: id ?? this.id,
        bairro: bairro ?? this.bairro,
        cep: cep ?? this.cep,
        cidade: cidade ?? this.cidade,
        complemento: complemento ?? this.complemento,
        contato: contato ?? this.contato,
        cpf: cpf ?? this.cpf,
        email: email ?? this.email,
        endereco: endereco ?? this.endereco,
        name: name ?? this.name,
        numero: numero ?? this.numero,
        perfil: perfil ?? this.perfil,
        status: status ?? this.status,
        uf: uf ?? this.uf,
        dadosBancarios: dadosBancarios ?? this.dadosBancarios,
        urls: urls ?? this.urls,
        isReferral: isReferral ?? this.isReferral,
        referral: referral ?? this.referral,
        motivoPendencia: motivoPendencia ?? this.motivoPendencia,
        dataCadastro: dataCadastro,
        passWord: passWord);
  }

  Users clear() {
    return copyWith(
      id: null,
      bairro: null,
      cep: null,
      cidade: null,
      complemento: null,
      contato: null,
      cpf: null,
      email: null,
      endereco: null,
      name: null,
      numero: null,
      perfil: null,
      status: null,
      uf: null,
      dadosBancarios: null,
      urls: null,
      isReferral: null,
      referral: null,
      motivoPendencia: null,
      password: null,
    );
  }
}

class TimestampConverter implements JsonConverter<Timestamp, Timestamp> {
  const TimestampConverter();

  @override
  Timestamp fromJson(Timestamp json) {
    return json;
  }

  @override
  Timestamp toJson(Timestamp object) {
    return object;
  }
}
