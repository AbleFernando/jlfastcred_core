import '../../jlfastcred_core.dart';

abstract interface class ClientService {
  Future<Either<ServiceException, Client>> searchClientByDocument(
      String document);
  Future<Either<ServiceException, Client>> searchClientById(String id);
  Future<Either<ServiceException, String>> registerClient(Client client);
  Future<Either<ServiceException, List<Client>>> searchClientForRegister();
}
