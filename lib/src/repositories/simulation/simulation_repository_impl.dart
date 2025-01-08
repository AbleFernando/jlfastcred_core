import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jlfastcred_core/jlfastcred_core.dart';
import 'package:jlfastcred_core/src/fp/nil.dart';
import 'package:jlfastcred_core/src/repositories/firebase/firebase_repository.dart';
import 'package:jlfastcred_core/src/repositories/firebase/firebase_repository_impl.dart';

class SimulationRepositoryImpl implements SimulationRepository {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseRepository _firebaseRepository = FirebaseRepositoryImpl();

  @override
  Future<Either<ServiceException, double>> obterTotalComissaoConsultor() async {
    double somatorio = 0;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection('comissao')
          .where('consultantID', isEqualTo: _auth.currentUser?.uid.toString())
          .where('pagamentoEfetuado', isEqualTo: false)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        somatorio += documentSnapshot['valor'] ?? 0;
      }
      return Right(somatorio);
    } catch (e, s) {
      log('Erro ao obter o total de comissao do consultor',
          error: e, stackTrace: s);
      return Left(ServiceException(
          message: 'Erro ao obter o total de comissao do consultor'));
    }
  }

  @override
  Future<Either<ServiceException, int>> obterQteTotalDigitacao() async {
    List<String> statusDigitacaoList = [
      'Paga',
      'Integrada',
      'Rejeitada',
      'Em andamento'
    ];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection('simulations')
          .where('consultant.id', isEqualTo: _auth.currentUser?.uid.toString())
          .where('status', isEqualTo: 'Aprovada')
          .where('statusDigitacao', whereIn: statusDigitacaoList)
          .get();
      return Right(querySnapshot.size);
    } catch (e, s) {
      log('Erro ao obter a quantidade total de digitacao',
          error: e, stackTrace: s);
      return Left(ServiceException(
          message: 'Erro ao obter a quantidade total de digitacao'));
    }
  }

  @override
  Future<Either<ServiceException, int>> obterQteTotalDigitacaoNoMes() async {
    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    List<String> statusDigitacaoList = [
      'Paga',
      'Integrada',
      'Rejeitada',
      'Em andamento'
    ];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection('simulations')
          .where('consultant.id', isEqualTo: _auth.currentUser?.uid.toString())
          .where('data_cadastro', isGreaterThanOrEqualTo: firstDayOfMonth)
          .where('status', isEqualTo: 'Aprovada')
          .where('statusDigitacao', whereIn: statusDigitacaoList)
          .get();

      return Right(querySnapshot.size);
    } catch (e, s) {
      log('Erro ao obter a quantidade total de digitacao no mes',
          error: e, stackTrace: s);
      return Left(ServiceException(
          message: 'Erro ao obter a quantidade total de digitacao no mes'));
    }
  }

  @override
  Future<Either<ServiceException, int>> obterQteTotalSimulacao() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection('simulations')
          .where('consultant.id', isEqualTo: _auth.currentUser?.uid.toString())
          .get();
      return Right(querySnapshot.size);
    } catch (e, s) {
      log('Erro ao obter a quantidade total de simulacao',
          error: e, stackTrace: s);
      return Left(ServiceException(
          message: 'Erro ao obter a quantidade total de simulacao'));
    }
  }

  @override
  Future<Either<ServiceException, int>> obterQteTotalSimulacaoNoMes() async {
    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection('simulations')
          .where('consultant.id', isEqualTo: _auth.currentUser?.uid.toString())
          .where('data_cadastro', isGreaterThanOrEqualTo: firstDayOfMonth)
          .get();
      return Right(querySnapshot.size);
    } catch (e, s) {
      log('Erro ao obter a quantidade total de simulacao no mes',
          error: e, stackTrace: s);
      return Left(ServiceException(
          message: 'Erro ao obter a quantidade total de simulacao no mes'));
    }
  }

  @override
  Future<Either<ServiceException, double>>
      obterValorTotalComissaoPagaNoMes() async {
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    double somatorio = 0;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection('comissao')
          .where('consultantID', isEqualTo: _auth.currentUser?.uid.toString())
          .where('dataEmissao', isGreaterThanOrEqualTo: firstDayOfMonth)
          .where('dataEmissao', isLessThanOrEqualTo: lastDayOfMonth)
          .where('pagamentoEfetuado',
              isEqualTo: true) // Considerando apenas pagamentos efetuados
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        somatorio += documentSnapshot['valor'] ?? 0;
      }
      return Right(somatorio);
    } catch (e, s) {
      log('Erro ao obter o valor total de comissao paga no mes',
          error: e, stackTrace: s);
      return Left(ServiceException(
          message: 'Erro ao obter o valor total de comissao paga no mes'));
    }
  }

  @override
  Future<Either<ServiceException, double>>
      obterValorTotalComissaoPagaNoTotal() async {
    double somatorio = 0;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection('comissao')
          .where('consultantID', isEqualTo: _auth.currentUser?.uid.toString())
          .where('pagamentoEfetuado', isEqualTo: true)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        somatorio += documentSnapshot['valor'] ?? 0;
      }
      return Right(somatorio);
    } catch (e, s) {
      log('Erro ao obter o valor total de comissao paga',
          error: e, stackTrace: s);
      return Left(ServiceException(
          message: 'Erro ao obter o valor total de comissao paga'));
    }
  }

  @override
  Future<Either<ServiceException, List<SimulationModel>>> obterSimulacaoPorTipo(
      String tipo) async {
    List<SimulationModel> listSimulation = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection('simulations')
          .where('consultant.id', isEqualTo: _auth.currentUser!.uid.toString())
          .where('operationType', isEqualTo: tipo.toUpperCase())
          .get();

      if (querySnapshot.size > 0) {
        for (var element in querySnapshot.docs) {
          log('Converntendo simulacao de ID:  ${element.id} ');
          listSimulation.add(SimulationModel.fromJson(element.data()));
        }
      }

      return Right(listSimulation);
    } catch (e, s) {
      log('Erro ao obter a listagem de simulacao por tipo',
          error: e, stackTrace: s);
      return Left(ServiceException(
          message: 'Erro ao obter a listagem de simulação por tipo'));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> cadastrarSimulacao(
      SimulationModel simulationModel) async {
    try {
      final user = await UserRepositoryImpl()
          .obtemUsuarioPorId(_auth.currentUser!.uid.toString());

      switch (user) {
        case Left(value: ServiceException(:var message)):
          throw ServiceException(message: message);
        case Right(value: final user):
          final doc =
              FirebaseFirestore.instance.collection("simulations").doc();
          log('ID da simulacao em fase de cadastro ${doc.id}');

          if (simulationModel.file != null) {
            final link = await FirebaseRepositoryImpl().uploadFileToFirebase(
                simulationModel.file!, 'simulations/${doc.id}/', 'anexo');

            switch (link) {
              case Left(value: ServiceException(:var message)):
                throw ServiceException(message: message);
              case Right(value: final caminho):
                await doc.set(simulationModel
                    .copyWith(
                        id: doc.id,
                        consultant: user,
                        margemUrl: [caminho].first)
                    .toJson());
            }
          } else {
            await doc.set(
              simulationModel.copyWith(id: doc.id, consultant: user).toJson(),
            );
          }
      }

      return Right(nil);
    } catch (e, s) {
      log('Erro ao criar a simulacao no firebase', error: e, stackTrace: s);
      return Left(ServiceException(message: 'Erro ao criar a simulação'));
    }
  }

  @override
  Future<Either<ServiceException, Nil>> reenviarSimulacao(
      SimulationModel simulationModel) async {
    try {
      // await _firebaseRepository.updateDocument(
      //     'simulations', simulationModel.id, simulationModel.toJson());

      await _firebaseRepository.updateDocument(
        collectionPath: 'simulations',
        docId: simulationModel.id,
        updatedData: simulationModel.toJson(),
      );

      return Right(nil);
    } catch (e, s) {
      log('Erro ao reenviar a simulacao no firebase', error: e, stackTrace: s);
      return Left(ServiceException(message: 'Erro ao reenviar a simulação'));
    }
  }

  @override
  Future<Either<ServiceException, List<SimulationModel>>>
      searchClientForRegister() async {
    List<SimulationModel> listClient = [];

    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return Left(ServiceException(message: 'Usuário não autenticado'));
    }

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection('simulations')
          .where('client.isClient', isEqualTo: false)
          .where('consultant.id', isEqualTo: currentUser.uid)
          .where('status', isEqualTo: 'Aprovada')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var element in querySnapshot.docs) {
          log('Convertendo simulação de ID: ${element.id}');
          listClient.add(SimulationModel.fromJson(element.data()));
        }
      }
      return Right(listClient);
    } catch (e, s) {
      log('Erro ao obter os dados do cliente no Firebase',
          error: e, stackTrace: s);
      return Left(
          ServiceException(message: 'Erro ao obter os dados do cliente'));
    }
  }

//E este
  @override
  Future<Either<ServiceException, String>> registerClient(
      File anexoFrenteDocumento,
      File anexoVersoDocumento,
      SimulationModel simulationModel) async {
    late final String frontDocumentUrl;
    late final String backDocumentUrl;

    try {
      // DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      //     await FirebaseFirestore.instance
      //         .collection('simulations')
      //         .doc(simulationModel.id)
      //         .get();

      // if (documentSnapshot.exists) {
      final resultVersoDocumento =
          await _firebaseRepository.uploadFileToFirebase(anexoVersoDocumento,
              'clientes/${simulationModel.id}', 'VersoDocumento');

      switch (resultVersoDocumento) {
        case Left(value: ServiceException(:var message)):
          return Left(ServiceException(message: message));
        case Right(value: final result):
          backDocumentUrl = result;
      }

      final resultFrenteDocumento =
          await _firebaseRepository.uploadFileToFirebase(anexoFrenteDocumento,
              'clientes/${simulationModel.id}', 'FrenteDocumento');

      switch (resultFrenteDocumento) {
        case Left(value: ServiceException(:var message)):
          return Left(ServiceException(message: message));
        case Right(value: final result):
          frontDocumentUrl = result;
      }

      // final simulation = SimulationModel.fromJson(documentSnapshot.data()!);

      await _firebaseRepository.updateDocument(
          collectionPath: 'simulations',
          docId: simulationModel.id,
          updatedData: simulationModel
              .copyWith(
                statusDigitacao: 'Aguardando Digitação',
                client: simulationModel.client.copyWith(
                  isCliente: true,
                  urls: Urls(
                      frontDocumentUrl: frontDocumentUrl,
                      backDocumentUrl: backDocumentUrl,
                      selfieUrl: '',
                      criminalRecordUrl: ''),
                ),
              )
              .toJson());

      // await _firebaseRepository.updateDocument(
      //     'simulations',
      //     simulationModel.id,
      //     simulationModel
      //         .copyWith(
      //           statusDigitacao: 'Aguardando Digitação',
      //           client: simulationModel.client.copyWith(
      //             isCliente: true,
      //             urls: Urls(
      //                 frontDocumentUrl: frontDocumentUrl,
      //                 backDocumentUrl: backDocumentUrl,
      //                 selfieUrl: '',
      //                 criminalRecordUrl: ''),
      //           ),
      //         )
      //         .toJson());

      return Right('Cliente castrado');
      // }

      // return Left(ServiceException(
      // message: 'Documento do cliente não existe no firebase'));
    } catch (e, s) {
      log('Erro ao cadastrar cliente no firebase', error: e, stackTrace: s);
      return Left(
          ServiceException(message: 'Erro ao cadastrar cliente no firebase'));
    }
  }
}
