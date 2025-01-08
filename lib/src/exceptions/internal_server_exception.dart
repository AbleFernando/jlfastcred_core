class InternalServerException implements Exception {
  final String message;

  InternalServerException({required this.message});
}

final class InternalServiceErro extends InternalServerException {
  InternalServiceErro({required super.message});
}
