import 'dart:io';

import 'package:jlfastcred_core/src/fp/nil.dart';
import '../../jlfastcred_core.dart';

class SimulationServiceImpl implements SimulationService {
  final SimulationRepository simulationRepository;
  final AdvanceRepository advanceRepository;
  // final ClientRepository clientRepository;

  SimulationServiceImpl({
    required this.simulationRepository,
    required this.advanceRepository,
    // required this.clientRepository,
  });

  @override
  Future<Either<ServiceException, double>> obterTotalComissaoConsultor() async {
    final result = await simulationRepository.obterTotalComissaoConsultor();

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final somatorio):
        //  String formattedValorReceber =
        // NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
        //     .format(valorReceber);
        return Right(somatorio);
    }
  }

  @override
  Future<Either<ServiceException, int>> obterQteTotalDigitacao() async {
    final result = await simulationRepository.obterQteTotalDigitacao();

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final qte):
        return Right(qte);
    }
  }

  @override
  Future<Either<ServiceException, int>> obterQteTotalDigitacaoNoMes() async {
    final result = await simulationRepository.obterQteTotalDigitacaoNoMes();

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final qte):
        return Right(qte);
    }
  }

  @override
  Future<Either<ServiceException, int>> obterQteTotalSimulacao() async {
    final result = await simulationRepository.obterQteTotalSimulacao();

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final qte):
        return Right(qte);
    }
  }

  @override
  Future<Either<ServiceException, int>> obterQteTotalSimulacaoNoMes() async {
    final result = await simulationRepository.obterQteTotalSimulacaoNoMes();

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final qte):
        return Right(qte);
    }
  }

  @override
  Future<Either<ServiceException, double>>
      obterValorTotalComissaoPagaNoMes() async {
    final result =
        await simulationRepository.obterValorTotalComissaoPagaNoMes();

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final somatorio):
        return Right(somatorio);
    }
  }

  @override
  Future<Either<ServiceException, double>>
      obterValorTotalComissaoPagaNoTotal() async {
    final result =
        await simulationRepository.obterValorTotalComissaoPagaNoTotal();

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final somatorio):
        return Right(somatorio);
    }
  }

  @override
  Future<Either<ServiceException, List<SimulationModel>>> obterSimulacaoPorTipo(
      String tipo) async {
    final result = await simulationRepository.obterSimulacaoPorTipo(tipo);

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final listSimulation):
        return Right(listSimulation);
    }
  }

  @override
  Future<Either<ServiceException, Nil>> cadastrarSimulacao(
      SimulationModel simulationModel) async {
    final result =
        await simulationRepository.cadastrarSimulacao(simulationModel);

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right():
        return Right(nil);
    }
  }

  @override
  Future<Either<ServiceException, Nil>> reenviarSimulacao(
      SimulationModel simulationModel) async {
    final result =
        await simulationRepository.reenviarSimulacao(simulationModel);

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right():
        return Right(nil);
    }
  }

  @override
  Future<Either<ServiceException, String>> requestAdvance() async {
    final resultSearch = await searchAdvance();

    switch (resultSearch) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final advance):
        if (advance.isEmpty()) {
          final result = await advanceRepository.requestAdvance();
          switch (result) {
            case Left(value: ServiceException(:var message)):
              return Left(ServiceException(message: message));
            case Right(value: final messagem):
              return Right(messagem);
          }
        } else {
          return Left(
            ServiceException(
                isErro: false,
                message:
                    'Você já possui uma solicitação de adiantamento em análise.'),
          );
        }
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

  @override
  Future<Either<ServiceException, List<SimulationModel>>>
      searchClientForRegister() async {
    final result = await simulationRepository.searchClientForRegister();

    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final cliente):
        return Right(cliente);
    }
  }

  @override
  Future<Either<ServiceException, String>> registerClient(
      File anexoFrenteDocumento,
      File anexoVersoDocumento,
      SimulationModel simulationModel) async {
    final result = await simulationRepository.registerClient(
        anexoFrenteDocumento, anexoVersoDocumento, simulationModel);
    switch (result) {
      case Left(value: ServiceException(:var message)):
        return Left(ServiceException(message: message));
      case Right(value: final users):
        return Right(users);
    }
  }
}
