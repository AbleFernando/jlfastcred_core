import 'package:jlfastcred_core/src/exceptions/service_exception.dart';
import 'package:jlfastcred_core/src/fp/either.dart';
import 'package:jlfastcred_core/src/model/advance.dart';
import 'package:jlfastcred_core/src/services/advance_service.dart';

import '../repositories/advance/advance_repository.dart';

class AdvanceServiceImpl implements AdvanceService {
  final AdvanceRepository advanceRepository;

  AdvanceServiceImpl({required this.advanceRepository});

  @override
  Future<Either<ServiceException, String>> requestAdvance() async {
    final result = await advanceRepository.requestAdvance();

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final messagem):
        return Right(messagem);
    }
  }

  @override
  Future<Either<ServiceException, Advance>> searchAdvance() async {
    final result = await advanceRepository.searchAdvance();

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final advance):
        return Right(advance);
    }
  }
}
