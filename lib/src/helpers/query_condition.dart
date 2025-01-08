class QueryCondition {
  final String field;
  final dynamic value;
  final String operator;
  final dynamic secondValue; // Para suportar o operador 'between'

  // Lista de operadores permitidos
  static const List<String> validOperators = [
    'isEqualTo',
    'isGreaterThan',
    'isGreaterThanOrEqualTo',
    'isLessThan',
    'isLessThanOrEqualTo',
    'arrayContains',
    'between',
  ];

  QueryCondition({
    required this.field,
    required this.value,
    this.operator = 'isEqualTo', // Define 'isEqualTo' como padrão
    this.secondValue, // O segundo valor é opcional e usado somente para o operador 'between'
  }) {
    // Validação do operador
    if (!validOperators.contains(operator)) {
      throw Exception('Operador inválido: $operator');
    }

    // Se o operador for 'between', o segundo valor deve ser fornecido
    if (operator == 'between' && secondValue == null) {
      throw Exception('O operador "between" requer um segundo valor.');
    }
  }
}
