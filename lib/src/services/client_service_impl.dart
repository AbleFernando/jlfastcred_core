import 'package:jlfastcred_core/src/exceptions/service_exception.dart';
import 'package:jlfastcred_core/src/fp/either.dart';
import 'package:jlfastcred_core/src/model/client.dart';
import 'package:jlfastcred_core/src/repositories/client/client_repository.dart';
import 'package:jlfastcred_core/src/services/client_service.dart';

class ClientServiceImpl implements ClientService {
  final ClientRepository clientRepository;

  ClientServiceImpl({required this.clientRepository});

  @override
  Future<Either<ServiceException, String>> registerClient(Client client) async {
    final result = await clientRepository.registerClient(client);

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final messagem):
        return Right(messagem);
    }
  }

  @override
  Future<Either<ServiceException, Client>> searchClientByDocument(
      String document) async {
    final result = await clientRepository.searchClientByDocument(document);

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final advance):
        return Right(advance);
    }
  }

  @override
  Future<Either<ServiceException, Client>> searchClientById(String id) async {
    final result = await clientRepository.searchClientByDocument(id);

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final advance):
        return Right(advance);
    }
  }

  @override
  Future<Either<ServiceException, List<Client>>>
      searchClientForRegister() async {
    final result = await clientRepository.searchClientForRegister();

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final cliente):
        return Right(cliente);
    }
  }
}
