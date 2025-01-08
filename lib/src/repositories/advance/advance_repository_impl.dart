import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jlfastcred_core/src/exceptions/service_exception.dart';
import 'package:jlfastcred_core/src/fp/either.dart';
import 'package:jlfastcred_core/src/model/advance.dart';
import 'package:jlfastcred_core/src/repositories/advance/advance_repository.dart';

class AdvanceRepositoryImpl implements AdvanceRepository {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Either<ServiceException, String>> requestAdvance() async {
    try {
      await _firebase.collection("adiantamento").add(
            Advance(
              consultantId: _auth.currentUser!.uid,
              consultantName: _auth.currentUser!.displayName!,
              dataSolicitacao: DateTime.now(),
              operationType: 'Adiantamento',
              status: AdvanceStatus.emAndamento,
            ).toJson(),
          );
      return Right('Adiantamento cadastrado com sucesso');
    } catch (e, s) {
      log('Erro ao cadastrar um adiantamento', error: e, stackTrace: s);
      return Left(ServiceException(message: 'Erro ao cadastra o adiantamento'));
    }
  }

  @override
  Future<Either<ServiceException, Advance>> searchAdvance() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firebase
          .collection('adiantamento')
          .where('consultantId', isEqualTo: _auth.currentUser!.uid)
          .where('status', isEqualTo: 'Em andamento')
          .get();

      if (snapshot.size > 0) {
        return Right(Advance.fromJson(snapshot.docs.first.data()));
      }

      return Right(Advance.empty());
    } catch (e, s) {
      log('Erro ao obter os dados de adiantamento do consultor',
          error: e, stackTrace: s);
      return Left(ServiceException(
          message: 'Erro ao obter os dados de adiantamento do consultor'));
    }
  }
}
