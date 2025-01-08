import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:jlfastcred_core/jlfastcred_core.dart';
import 'package:jlfastcred_core/src/exceptions/auth_exception.dart';

import '../../fp/nil.dart';

abstract interface class UserRepository {
  Future<Either<AuthError, UserCredential>> login(
      String email, String password);

  Future<Either<ServiceException, Nil>> resetPassWord(String email);

  Future<Either<ServiceException, Users>> obtemUsuarioPorId(String userId);

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
