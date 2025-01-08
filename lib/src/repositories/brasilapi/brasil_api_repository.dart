import 'package:jlfastcred_core/src/exceptions/service_exception.dart';
import 'package:jlfastcred_core/src/fp/either.dart';
import 'package:jlfastcred_core/src/model/brasilapi/bank_details.dart';
import 'package:jlfastcred_core/src/model/brasilapi/cep_v1.dart';

abstract interface class BrasilApiRepository {
  Future<Either<ServiceException, CepV1>> fetchAddressByCep(String cep);
  Future<Either<ServiceException, List<BankDetails>>> fetchBankList();
}
