import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jlfastcred_core/src/exceptions/service_exception.dart';
import 'package:jlfastcred_core/src/fp/either.dart';
import 'package:jlfastcred_core/src/model/client.dart';
import 'package:jlfastcred_core/src/repositories/client/client_repository.dart';

import '../firebase/firebase_repository_impl.dart';

class ClientRepositoryImpl implements ClientRepository {
  final _collectionName = 'clientes';
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  Future<Either<ServiceException, Client>> searchClientByDocument(
      String document) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection(_collectionName)
          .where('cpfOrBenefitNumber', isEqualTo: document)
          .get();

      if (querySnapshot.size > 0) {
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs.first;
        return Right(Client.fromJson(documentSnapshot.data()!));
      } else {
        log('Cliente nao encontrado no firebase');
        return Left(ServiceException(message: 'Cliente não encontrado'));
      }
    } catch (e, s) {
      log('Erro ao obter os dados do cliente no firebase',
          error: e, stackTrace: s);
      return Left(
          ServiceException(message: 'Erro ao obter os dados do cliente'));
    }
  }

  @override
  Future<Either<ServiceException, Client>> searchClientById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection(_collectionName)
              .doc(id)
              .get();

      if (documentSnapshot.exists) {
        return Right(Client.fromJson(documentSnapshot.data()!));
      } else {
        log('Cliente nao encontrado no firebase');
        return Left(ServiceException(message: 'Cliente não encontrado'));
      }
    } catch (e, s) {
      log('Erro ao obter os dados do cliente no firebase',
          error: e, stackTrace: s);
      return Left(
          ServiceException(message: 'Erro ao obter os dados do cliente'));
    }
  }

  @override
  Future<Either<ServiceException, String>> registerClient(Client client) async {
    try {
      await FirebaseRepositoryImpl()
          .addDocument(collectionPath: _collectionName, data: client.toJson());

      log('Cliente cadastrado com sucesso');
      return Right('Cliente cadastrado com sucesso');
    } catch (e, s) {
      log('Erro ao cadastrar um cliente', error: e, stackTrace: s);
      return Left(ServiceException(message: 'Erro ao cadastra o cliente'));
    }
  }

  @override
  Future<Either<ServiceException, List<Client>>>
      searchClientForRegister() async {
    List<Client> listClient = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection(_collectionName)
          .where('is_client', isEqualTo: false)
          .get();

      if (querySnapshot.size > 0) {
        for (var element in querySnapshot.docs) {
          log('Converntendo simulacao de ID:  ${element.id} ');
          listClient.add(Client.fromJson(element.data()));
        }
      }
      return Right(listClient);
    } catch (e, s) {
      log('Erro ao obter os dados do cliente no firebase',
          error: e, stackTrace: s);
      return Left(
          ServiceException(message: 'Erro ao obter os dados do cliente'));
    }
  }
}
