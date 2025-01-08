class ServiceException implements Exception {
  final String message;
  final bool isErro;

  ServiceException({this.message = '', this.isErro = true});
}
