import 'package:jlfastcred_core/src/exceptions/service_exception.dart';
import 'package:jlfastcred_core/src/fp/either.dart';
import 'package:jlfastcred_core/src/model/brasilapi/bank_details.dart';
import 'package:jlfastcred_core/src/repositories/brasilapi/brasil_api_repository.dart';
import 'package:jlfastcred_core/src/services/brasilapi/brasil_api_service.dart';

import '../../model/brasilapi/cep_v1.dart';

class BrasilApiServiceImpl implements BrasilApiService {
  final BrasilApiRepository brasilApiRepository;

  BrasilApiServiceImpl({required this.brasilApiRepository});

  @override
  Future<Either<ServiceException, CepV1>> fetchAddressByCep(String cep) async {
    final result = await brasilApiRepository.fetchAddressByCep(cep);
    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final cepV1):
        return Right(cepV1);
    }
  }

  @override
  Future<Either<ServiceException, List<BankDetails>>> fetchBankList() async {
    final result = await brasilApiRepository.fetchBankList();
    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final bankDetails):
        return Right(bankDetails);
    }
  }
}
