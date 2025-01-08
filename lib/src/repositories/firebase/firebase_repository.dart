import 'dart:io';

import 'package:jlfastcred_core/jlfastcred_core.dart';
import 'package:jlfastcred_core/src/helpers/query_condition.dart';

abstract interface class FirebaseRepository {
// Future<void> addDocument(String collectionName, Map<String, dynamic> data);
  // Future<void> deleteDocument(String collectionName, String documentId);
  // Future<List<Map<String, dynamic>>> getDocuments(String collectionName);
  // Future<Map<String, dynamic>?> getDocumentById(
  //     String collectionName, String documentId);
  // Future<void> updateDocument(
  //     String collectionName, String documentId, Map<String, dynamic> data);
  // Future<List<Map<String, dynamic>>> queryCollectionWithConditions(
  //   String collectionName,
  //   Map<String, dynamic> conditions,
  // );

  Future<void> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? docId,
    String? subcollectionPath,
  });

  Future<void> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> updatedData,
    String? subcollectionPath,
  });

  Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
    String? subcollectionPath,
  });

  Future<List<Map<String, dynamic>>> getDocuments({
    required String collectionPath,
    String? subcollectionPath,
    String? docId,
  });

  Future<Map<String, dynamic>?> getDocumentById({
    required String collectionPath,
    required String docId,
    String? subcollectionPath,
  });

  Future<List<Map<String, dynamic>>> getDocumentsWithMultipleWhere({
    required String collectionPath,
    required List<QueryCondition> conditions, // Lista de objetos QueryCondition
    String? subcollectionPath,
    String? docId,
  });

  Future<Either<ServiceException, String>> uploadFileToFirebase(
      File file, String path, String fileName);
}
