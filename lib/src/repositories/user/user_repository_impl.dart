import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jlfastcred_core/jlfastcred_core.dart';
import 'package:jlfastcred_core/src/exceptions/auth_exception.dart';

import 'package:jlfastcred_core/src/fp/nil.dart';
import 'package:jlfastcred_core/src/repositories/firebase/firebase_repository.dart';
import 'package:jlfastcred_core/src/repositories/firebase/firebase_repository_impl.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseRepository _firebaseRepository = FirebaseRepositoryImpl();

  @override
  Future<Either<AuthError, UserCredential>> login(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      obtemUsuarioPorId(_auth.currentUser!.uid);

      return Right(userCredential);
    } catch (e, s) {
      if (e is FirebaseAuthException) {
        String errorCode = e.code;
        log('Erro durante o login. Código de erro: $errorCode',
            error: e, stackTrace: s);
        return Left(AuthError(message: 'Erro ao realizar login'));
      } else {
        log('Internal Service Error durante o login: $e',
            error: e, stackTrace: s);
        return Left(
            AuthError(message: 'Internal Service Error durante o login'));
      }
    }
  }

  @override
  Future<Either<ServiceException, Nil>> resetPassWord(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Right(nil);
    } catch (e, s) {
      log('Erro ao enviar o e-mail para resetar a senha',
          error: e, stackTrace: s);
      return Left(ServiceException(
          message: 'Erro ao enviar o e-mail para resetar a senha'));
    }
  }

  @override
  Future<Either<ServiceException, Users>> obtemUsuarioPorId(
      String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
      if (documentSnapshot.exists) {
        final users = Users.fromJson(documentSnapshot.data()!);

        _auth.currentUser!.updateDisplayName(users.name);
        _auth.currentUser!.updatePhotoURL(users.urls.selfieUrl);

        return Right(users);
        // return Right(Users.fromJson(documentSnapshot.data()!));
      } else {
        return Left(ServiceException(message: 'Usuário não encontrado'));
      }
    } catch (e, s) {
      log('Erro ao obter os dados do usuário no firebase',
          error: e, stackTrace: s);
      return Left(
          ServiceException(message: 'Erro ao obter os dados do usuario'));
    }
  }

  @override
  Future<Either<ServiceException, Users>> findConsultantByDocument(
      String document) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebase
          .collection('users')
          .where('cpf', isEqualTo: document)
          // .where('status', isEqualTo: UsersStatus.cadastrando.name)
          .get();

      if (querySnapshot.size > 0) {
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs.first;
        // final Users user = Users.fromJson(documentSnapshot.data()!);
        // if (user.status == UsersStatus.cadastrando.name) {
        //   return Right(user);
        // } else {
        //   log('Usuário já cadastrado no sistema');
        //   return Left(
        //       ServiceException(message: 'Usuário não pode ser cadastrado'));
        // }
        return Right(Users.fromJson(documentSnapshot.data()!));
      } else {
        return Right(Users.empty());
      }
    } catch (e, s) {
      log('Erro ao obter os dados do usuário no firebase',
          error: e, stackTrace: s);
      return Left(
          ServiceException(message: 'Erro ao obter os dados do usuario'));
    }
  }

  @override
  Future<Either<ServiceException, Users>> register(Users consultant) async {
    try {
      final String userId;

      if (consultant.passWord != null) {
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: consultant.email,
          password: consultant.passWord!,
        );
        userId = userCredential.user!.uid;

        userCredential.user!.updateDisplayName(consultant.name);
        userCredential.user!.updatePhotoURL(consultant.urls.selfieUrl);
      } else {
        userId = consultant.id;
      }

      Users tempUsers;

      if (consultant.urls.backDocumentUrl.isNotEmpty &&
          consultant.urls.selfieUrl.isNotEmpty &&
          consultant.urls.frontDocumentUrl.isNotEmpty &&
          consultant.urls.criminalRecordUrl.isNotEmpty) {
        tempUsers =
            consultant.copyWith(id: userId, status: 'Pendente Aprovação');

        await _firebase.collection('users').doc(userId).set(tempUsers.toJson());
      } else {
        tempUsers = consultant.copyWith(
            id: userId, status: UsersStatus.cadastrando.name);

        await _firebase.collection('users').doc(userId).set(tempUsers.toJson());
      }

      return Right(tempUsers);
    } catch (e, s) {
      log('Erro ao obter os dados do usuário no firebase',
          error: e, stackTrace: s);
      return Left(
          ServiceException(message: 'Erro ao obter os dados do usuario'));
    }
  }

  @override
  Future<Either<ServiceException, String>> registerWithDocument(
      Users consultant,
      File anexoFrenteDocumento,
      File anexoVersoDocumento,
      File anexoAntecedenteCriminal,
      File anexoSelf) async {
    try {
      late final String frontDocumentUrl;
      late final String backDocumentUrl;
      late final String selfieUrl;
      late final String criminalRecordUrl;

      final resultSelf = await _firebaseRepository.uploadFileToFirebase(
          anexoSelf, 'users/${consultant.id}', 'Self');

      switch (resultSelf) {
        case Left(value: ServiceException(:var message)):
          return Left(ServiceException(message: message));
        case Right(value: final result):
          selfieUrl = result;
      }

      final resultAntecedenteCriminal =
          await _firebaseRepository.uploadFileToFirebase(
              anexoAntecedenteCriminal,
              'users/${consultant.id}',
              'AntecedenteCriminal');

      switch (resultAntecedenteCriminal) {
        case Left(value: ServiceException(:var message)):
          return Left(ServiceException(message: message));
        case Right(value: final result):
          criminalRecordUrl = result;
      }

      final resultVersoDocumento =
          await _firebaseRepository.uploadFileToFirebase(
              anexoVersoDocumento, 'users/${consultant.id}', 'VersoDocumento');

      switch (resultVersoDocumento) {
        case Left(value: ServiceException(:var message)):
          return Left(ServiceException(message: message));
        case Right(value: final result):
          backDocumentUrl = result;
      }

      final resultFrenteDocumento =
          await _firebaseRepository.uploadFileToFirebase(anexoFrenteDocumento,
              'users/${consultant.id}', 'FrenteDocumento');

      switch (resultFrenteDocumento) {
        case Left(value: ServiceException(:var message)):
          return Left(ServiceException(message: message));
        case Right(value: final result):
          frontDocumentUrl = result;
      }

      consultant.urls = Urls(
          frontDocumentUrl: frontDocumentUrl,
          backDocumentUrl: backDocumentUrl,
          selfieUrl: selfieUrl,
          criminalRecordUrl: criminalRecordUrl);

      consultant.status = UsersStatus.novo.name;

      register(consultant);

      return Right('Registro efetuado com sucesso');
    } catch (e, s) {
      log('Erro ao obter os dados do usuario no firebase',
          error: e, stackTrace: s);
      return Left(
          ServiceException(message: 'Erro ao obter os dados do usuário'));
    }
  }
}
