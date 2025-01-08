import 'dart:io';

import 'package:jlfastcred_core/jlfastcred_core.dart';

abstract interface class UserService {
  Future<Either<ServiceException, Users>> findConsultantByDocument(
      String document);

  Future<Either<ServiceException, Users>> register(Users consultant);

  Future<Either<ServiceException, String>> registerWithDocument(
      Users consultant,
      File anexoFrenteDocumento,
      File anexoVersoDocumento,
      File anexoAntecedenteCriminal,
      File anexoSelf);
}
