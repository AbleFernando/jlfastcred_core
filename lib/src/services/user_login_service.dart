import 'package:firebase_auth/firebase_auth.dart';
import 'package:jlfastcred_core/src/exceptions/service_exception.dart';
import 'package:jlfastcred_core/src/fp/either.dart';
import 'package:jlfastcred_core/src/fp/nil.dart';
import 'package:jlfastcred_core/src/model/users.dart';

abstract interface class UserLoginService {
  Future<Either<ServiceException, UserCredential>> execute(
      String email, String password);

  Future<Either<ServiceException, Nil>> resetPassWord(String email);

  Future<Either<ServiceException, Users>> obtemUsuarioPorId(String userId);
}
