import 'dart:io';

import 'package:jlfastcred_core/jlfastcred_core.dart';

import '../fp/nil.dart';

abstract interface class SimulationService {
  Future<Either<ServiceException, double>> obterTotalComissaoConsultor();
  Future<Either<ServiceException, double>> obterValorTotalComissaoPagaNoMes();
  Future<Either<ServiceException, double>> obterValorTotalComissaoPagaNoTotal();
  Future<Either<ServiceException, int>> obterQteTotalSimulacaoNoMes();
  Future<Either<ServiceException, int>> obterQteTotalSimulacao();
  Future<Either<ServiceException, int>> obterQteTotalDigitacaoNoMes();
  Future<Either<ServiceException, int>> obterQteTotalDigitacao();
  Future<Either<ServiceException, List<SimulationModel>>> obterSimulacaoPorTipo(
      String tipo);
  Future<Either<ServiceException, Nil>> cadastrarSimulacao(
      SimulationModel simulationModel);
  Future<Either<ServiceException, Nil>> reenviarSimulacao(
      SimulationModel simulationModel);

  //Advance
  Future<Either<ServiceException, String>> requestAdvance();
  Future<Either<ServiceException, Advance>> searchAdvance();

  //Client
  Future<Either<ServiceException, List<SimulationModel>>>
      searchClientForRegister();

  Future<Either<ServiceException, String>> registerClient(
      File anexoFrenteDocumento,
      File anexoVersoDocumento,
      SimulationModel simulationModel);
}
