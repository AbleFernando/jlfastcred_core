class FirebaseException implements Exception {
  final String message;

  FirebaseException({required this.message});
}

final class SearchError extends FirebaseException {
  SearchError({required super.message});
}

final class InsertError extends FirebaseException {
  InsertError({required super.message});
}

final class DeleteError extends FirebaseException {
  DeleteError({required super.message});
}

final class UpdateError extends FirebaseException {
  UpdateError({required super.message});
}
