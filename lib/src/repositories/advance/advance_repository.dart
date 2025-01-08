import '../../../jlfastcred_core.dart';

abstract interface class AdvanceRepository {
  Future<Either<ServiceException, String>> requestAdvance();
  Future<Either<ServiceException, Advance>> searchAdvance();
}
