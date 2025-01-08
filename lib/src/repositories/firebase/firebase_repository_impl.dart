import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jlfastcred_core/src/exceptions/firebase_exception.dart';
import 'package:jlfastcred_core/src/exceptions/service_exception.dart';
import 'package:jlfastcred_core/src/fp/either.dart';
import 'package:jlfastcred_core/src/helpers/query_condition.dart';

import 'firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Método para adicionar um documento em uma coleção ou subcoleção
  @override
  Future<void> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? docId,
    String? subcollectionPath,
  }) async {
    try {
      CollectionReference collectionRef = _firestore.collection(collectionPath);

      // Se uma subcoleção for passada
      if (subcollectionPath != null) {
        collectionRef = collectionRef.doc(docId!).collection(subcollectionPath);
      }

      // Adicionando o documento
      if (docId == null) {
        await collectionRef.add(data); // Gera um ID automaticamente
      } else {
        await collectionRef.doc(docId).set(data); // Usa o ID passado
      }
    } catch (e, s) {
      log('Error adding document: $e', error: e, stackTrace: s);
      rethrow;
    }
    throw InsertError(
        message:
            'Erro ao tentar inserir o documento na colecao $subcollectionPath');
  }

  // @override
  // Future<void> addDocument(
  //     String collectionName, Map<String, dynamic> data) async {
  //   try {
  //     log('Adding document to $collectionName: $data');
  //     await _firestore.collection(collectionName).add(data);
  //     log('Document added successfully');
  //   } catch (e, s) {
  //     log('Error adding document: $e', error: e, stackTrace: s);
  //     throw InsertError(
  //         message:
  //             'Erro ao tentar inserir o documento na colecao $collectionName');
  //   }
  // }

  // @override
  // Future<void> deleteDocument(String collectionName, String documentId) {
  //   // TODO: implement deleteDocument
  //   throw UnimplementedError();
  // }

  // Método para deletar um documento
  @override
  Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
    String? subcollectionPath,
  }) async {
    try {
      DocumentReference documentRef =
          _firestore.collection(collectionPath).doc(docId);

      // Se for uma subcoleção, ajusta a referência
      if (subcollectionPath != null) {
        documentRef = documentRef.collection(subcollectionPath).doc(docId);
      }

      // Deletando o documento
      await documentRef.delete();
    } catch (e, s) {
      log('Error deleting document: $e', error: e, stackTrace: s);
      rethrow;
    }
  }

  // @override
  // Future<Map<String, dynamic>?> getDocumentById(
  //     String collectionName, String documentId) {
  //   // TODO: implement getDocumentById
  //   throw UnimplementedError();
  // }
  // Método para buscar um único documento
  @override
  Future<Map<String, dynamic>?> getDocumentById({
    required String collectionPath,
    required String docId,
    String? subcollectionPath,
  }) async {
    try {
      DocumentReference documentRef =
          _firestore.collection(collectionPath).doc(docId);

      // Se for uma subcoleção, ajusta a referência
      if (subcollectionPath != null) {
        documentRef = documentRef.collection(subcollectionPath).doc(docId);
      }

      // Recuperando o documento
      DocumentSnapshot docSnapshot = await documentRef.get();
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>?;
      } else {
        return null; // Documento não encontrado
      }
    } catch (e, s) {
      log('Error deleting document: $e', error: e, stackTrace: s);
      rethrow;
    }
  }

  // @override
  // Future<List<Map<String, dynamic>>> getDocuments(String collectionName) {
  //   // TODO: implement getDocuments
  //   throw UnimplementedError();
  // }

  // Método para buscar documentos de uma coleção ou subcoleção
  Future<List<Map<String, dynamic>>> getDocuments({
    required String collectionPath,
    String? subcollectionPath,
    String? docId,
  }) async {
    try {
      CollectionReference collectionRef = _firestore.collection(collectionPath);

      // Se for uma subcoleção, ajusta a referência
      if (subcollectionPath != null && docId != null) {
        collectionRef = collectionRef.doc(docId).collection(subcollectionPath);
      }

      // Recuperando os documentos
      QuerySnapshot snapshot = await collectionRef.get();
      List<Map<String, dynamic>> documents = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return documents;
    } catch (e, s) {
      log('Error get documents: $e', error: e, stackTrace: s);
      rethrow;
    }
  }

  // @override
  // Future<void> updateDocument(String collectionName, String documentId,
  //     Map<String, dynamic> data) async {
  //   await FirebaseFirestore.instance
  //       .collection(collectionName)
  //       .doc(documentId)
  //       .set(data);
  // }

  // Método para atualizar um documento existente
  @override
  Future<void> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> updatedData,
    String? subcollectionPath,
  }) async {
    try {
      DocumentReference documentRef =
          _firestore.collection(collectionPath).doc(docId);

      // Se for uma subcoleção, ajusta a referência
      if (subcollectionPath != null) {
        documentRef = documentRef.collection(subcollectionPath).doc(docId);
      }

      // Atualizando o documento
      await documentRef.update(updatedData);
    } catch (e, s) {
      log('Error get documents: $e', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<Either<ServiceException, String>> uploadFileToFirebase(
      File file, String path, String fileName) async {
    String url;
    try {
      final String fileType = file.path.split('.').last;

      final String mimeType;
      if (fileType == 'jpg' || fileType == 'jpeg') {
        mimeType = 'image/jpeg';
      } else if (fileType == 'png') {
        mimeType = 'image/png';
      } else if (fileType == 'pdf') {
        mimeType = 'application/pdf';
      } else {
        mimeType = 'application/octet-stream';
      }

      Reference reference =
          _firebaseStorage.ref().child('/$path/$fileName.$fileType');
      UploadTask uploadTask = reference.putFile(
        file,
        SettableMetadata(contentType: mimeType),
      );
      TaskSnapshot taskSnapshot = await uploadTask;
      url = await taskSnapshot.ref.getDownloadURL();

      return Right(url);
    } catch (e, s) {
      log('Erro ao obter realizar o upload do arquivo para o firestore',
          error: e, stackTrace: s);
      return Left(ServiceException(message: 'Erro ao salvar o arquivo'));
    }
  }

  // @override
  // Future<List<Map<String, dynamic>>> queryCollectionWithConditions(
  //     String collectionName, Map<String, dynamic> conditions) {
  //   // TODO: implement queryCollectionWithConditions
  //   throw UnimplementedError();
  // }

  @override
  Future<List<Map<String, dynamic>>> getDocumentsWithMultipleWhere({
    required String collectionPath,
    required List<QueryCondition> conditions, // Lista de objetos QueryCondition
    String? subcollectionPath,
    String? docId,
  }) async {
    try {
      CollectionReference collectionRef = _firestore.collection(collectionPath);

      // Se for uma subcoleção, ajusta a referência
      if (subcollectionPath != null && docId != null) {
        collectionRef = collectionRef.doc(docId).collection(subcollectionPath);
      }

      // Aplicando múltiplas condições 'where' usando a classe QueryCondition
      Query query = collectionRef;
      for (var condition in conditions) {
        switch (condition.operator) {
          case 'isEqualTo':
            query = query.where(condition.field, isEqualTo: condition.value);
            break;
          case 'isGreaterThan':
            query =
                query.where(condition.field, isGreaterThan: condition.value);
            break;
          case 'isGreaterThanOrEqualTo':
            query = query.where(condition.field,
                isGreaterThanOrEqualTo: condition.value);
            break;
          case 'isLessThan':
            query = query.where(condition.field, isLessThan: condition.value);
            break;
          case 'isLessThanOrEqualTo':
            query = query.where(condition.field,
                isLessThanOrEqualTo: condition.value);
            break;
          case 'arrayContains':
            query =
                query.where(condition.field, arrayContains: condition.value);
            break;
          case 'between':
            query = query
                .where(condition.field, isGreaterThanOrEqualTo: condition.value)
                .where(condition.field,
                    isLessThanOrEqualTo: condition.secondValue);
            break;
          // Adicione outros operadores conforme necessário
          default:
            throw Exception('Operador desconhecido: ${condition.operator}');
        }
      }

      // Recuperando os documentos que atendem às condições
      QuerySnapshot snapshot = await query.get();
      List<Map<String, dynamic>> documents = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return documents;
    } catch (e, s) {
      log('Erro ao realizar a busca no firebase', error: e, stackTrace: s);
      rethrow;
    }
  }
}
