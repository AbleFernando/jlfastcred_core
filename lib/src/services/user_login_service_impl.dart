import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:jlfastcred_core/src/exceptions/auth_exception.dart';
import 'package:jlfastcred_core/src/exceptions/service_exception.dart';
import 'package:jlfastcred_core/src/fp/either.dart';
import 'package:jlfastcred_core/src/fp/nil.dart';
import 'package:jlfastcred_core/src/model/users.dart';
import 'package:jlfastcred_core/src/repositories/user/user_repository.dart';
import 'package:jlfastcred_core/src/services/user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;

  UserLoginServiceImpl({required this.userRepository});

  // @override
  // Future<Either<ServiceException, UserCredential>> execute(
  //     String email, String password) async {
  //   final loginResult = await userRepository.login(email, password);

  //   switch (loginResult) {
  //     case Left(value: AuthError(:var message)):
  //       log(message);
  //       return Left(ServiceException(message: 'Erro ao realizar login'));
  //     // case Left(value: AuthUnauthorizedException()):
  //     //   return Left(ServiceException(message: 'Login ou senha inválidos'));
  //     case Right(value: final userCredential):
  //       final users = obtemUsuarioPorId(userCredential.user!.uid);

  //       return Right(userCredential);
  //   }
  // }

  @override
  Future<Either<ServiceException, UserCredential>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Left(value: AuthError(:var message)):
        log(message);
        return Left(ServiceException(message: 'Erro ao realizar login'));
      // case Left(value: AuthUnauthorizedException()):
      //   return Left(ServiceException(message: 'Login ou senha inválidos'));
      case Right(value: final userCredential):
        final obtemUsuarioResult =
            await obtemUsuarioPorId(userCredential.user!.uid);

        switch (obtemUsuarioResult) {
          case Left(value: ServiceException(:final message)):
            return Left(ServiceException(message: message));
          case Right(value: final users):
            log(users.name);
            if (users.status == 'Pendente Aprovação') {
              return Left(ServiceException(
                  message: 'Perfil em aprovação, por favor aguarde',
                  isErro: false));
            } else if (users.status == UsersStatus.cadastrando.name) {
              return Left(ServiceException(
                  message:
                      'Perfil com cadastro pendente, por favor termine a etapa de criação da conta',
                  isErro: false));
            } else if (users.status == UsersStatus.devolvido.name) {
              return Left(ServiceException(
                  message: 'Cadastro com pendência: ${users.motivoPendencia}',
                  isErro: false));
            } else if (users.status == UsersStatus.reprovado.name) {
              return Left(ServiceException(message: 'Cadastro reprovado'));
            }
        }
        return Right(userCredential);
    }
  }

  @override
  Future<Either<ServiceException, Nil>> resetPassWord(String email) async {
    final result = await userRepository.resetPassWord(email);

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right():
        return Right(nil);
    }
  }

  @override
  Future<Either<ServiceException, Users>> obtemUsuarioPorId(
      String userId) async {
    final result = await userRepository.obtemUsuarioPorId(userId);

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final users):
        return Right(users);
    }
  }
}
