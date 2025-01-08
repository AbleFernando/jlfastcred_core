import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jlfastcred_core/src/exceptions/service_exception.dart';
import 'package:jlfastcred_core/src/fp/either.dart';
import 'package:jlfastcred_core/src/model/brasilapi/bank_details.dart';
import 'package:jlfastcred_core/src/model/brasilapi/cep_v1.dart';
import 'package:jlfastcred_core/src/repositories/brasilapi/brasil_api_repository.dart';
import 'package:jlfastcred_core/src/restClient/rest_client.dart';

class BrasilApiRepositoryImpl implements BrasilApiRepository {
  final RestClient restClient;

  BrasilApiRepositoryImpl({required this.restClient});

  @override
  Future<Either<ServiceException, CepV1>> fetchAddressByCep(String cep) async {
    try {
      // Faz a requisição à API e espera a resposta.
      final Response response = await restClient.unauth
          .get('/cep/v1/${cep.replaceAll(RegExp(r'[^0-9]'), '')}');

      // Certifique-se de que o mapeamento para CepV1 é feito corretamente
      final cepV1 = CepV1.fromJson(response.data);

      return Right(cepV1);
    } on DioException catch (e, s) {
      log("Erro ao buscar CEP", error: e, stackTrace: s);

      // Trata o erro com base no código de status
      if (e.response?.statusCode == HttpStatus.forbidden) {
        return Left(
            ServiceException(message: 'Acesso proibido ao serviço de CEP'));
      } else {
        return Left(ServiceException(message: 'Erro ao buscar CEP'));
      }
    }
  }

  @override
  Future<Either<ServiceException, List<BankDetails>>> fetchBankList() async {
    try {
      // Faz a chamada à API para obter os dados bancários, sem parâmetros adicionais
      final Response response = await restClient.unauth.get('/banks/v1');

      // Converte a resposta (uma lista de mapas) em uma lista de objetos BankDetails
      final List<BankDetails> bankDetails = (response.data as List<dynamic>)
          .where((bank) =>
              bank['name'] != null &&
              bank['fullName'] != null &&
              bank['code'] != null)
          .map((bank) => BankDetails.fromJson(bank as Map<String, dynamic>))
          .toList();

      return Right(bankDetails);
    } on DioException catch (e, s) {
      log("Erro ao buscar dados bancários", error: e, stackTrace: s);
      return switch (e) {
        DioException(response: Response(statusCode: HttpStatus.forbidden)?) =>
          Left(ServiceException(message: "Acesso negado")),
        _ => Left(ServiceException(message: 'Erro ao buscar dados bancários'))
      };
    }
  }
}
