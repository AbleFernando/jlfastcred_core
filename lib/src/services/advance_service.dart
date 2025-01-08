import 'package:jlfastcred_core/jlfastcred_core.dart';

abstract interface class AdvanceService {
  Future<Either<ServiceException, String>> requestAdvance();
  Future<Either<ServiceException, Advance>> searchAdvance();
}
