import 'dart:developer';
import 'dart:io';

import 'package:jlfastcred_core/jlfastcred_core.dart';

// Um service é uma camada que contém a lógica de negócios da aplicação.
// Ele coordena operações entre repositórios e outras camadas da aplicação,
// aplicando as regras de negócio necessárias.
//Resumo: Contém a lógica de negócios e regras da aplicação.
class UserServiceImpl implements UserService {
  final UserRepository userRepository;

  UserServiceImpl({required this.userRepository});

  @override
  Future<Either<ServiceException, Users>> findConsultantByDocument(
      String document) async {
    final result = await userRepository.findConsultantByDocument(document);

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final users):
        if (users.status == UsersStatus.cadastrando.name ||
            users.status.toLowerCase() == UsersStatus.devolvido.name) {
          return Right(users);
        } else {
          if (users.status == '') {
            log('Usuario liberado para cadsatro no sistema');
            return Right(users.copyWith(cpf: document));
            // } else if (users.status.toLowerCase() == UsersStatus.devolvido.name) {
            //   log('Usuario devolvido');
            //   return Left(
            //     ServiceException(
            //         message: 'Usuário reprovador, por favor ajuste seu cadsatro',
            //         isErro: false),
            //   );
          }
          log('Usuario ja cadastrado no sistema');
          return Left(
              ServiceException(message: 'Usuário não pode ser cadastrado'));
        }
      // return Right(users);
    }
  }

  @override
  Future<Either<ServiceException, Users>> register(Users consultant) async {
    final result = await userRepository.register(consultant);
    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final users):
        return Right(users);
    }
  }

  @override
  Future<Either<ServiceException, String>> registerWithDocument(
      Users consultant,
      File anexoFrenteDocumento,
      File anexoVersoDocumento,
      File anexoAntecedenteCriminal,
      File anexoSelf) async {
    dynamic result;

    if (anexoFrenteDocumento.path.isNotEmpty &&
        anexoVersoDocumento.path.isNotEmpty &&
        anexoAntecedenteCriminal.path.isNotEmpty &&
        anexoSelf.path.isNotEmpty) {
      result = await userRepository.registerWithDocument(
          consultant,
          anexoFrenteDocumento,
          anexoVersoDocumento,
          anexoAntecedenteCriminal,
          anexoSelf);
    } else {
      await userRepository.register(consultant);
      result = Right('Registro efetuado com sucesso');
    }

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final users):
        return Right(users);
      default:
        // Caso nenhum dos dois casos corresponda, retornamos um erro genérico
        return Left(
            ServiceException(message: 'Erro desconhecido ao registrar.'));
    }
  }
}
