import 'package:flutter_test/flutter_test.dart';

import 'calculos.dart';

void main() {
  test('Teste de cálculo de IMC e classificação', () {
    final testData = [
      {'altura': 170.0, 'peso': 70.0, 'resultado': 24.22, 'classificacao': 'Saudável'},
      {'altura': 100.0, 'peso': 120.0, 'resultado': 120.00, 'classificacao': 'Obesidade Grau III (mórbida)'},
      {'altura': 170.0, 'peso': 90.0, 'resultado': 31.14, 'classificacao': 'Obesidade Grau I'},
      {'altura': 160.0, 'peso': 60.0, 'resultado': 23.44, 'classificacao': 'Saudável'},
      {'altura': 170.0, 'peso': 100.0, 'resultado': 34.60, 'classificacao': 'Obesidade Grau I'},
      {'altura': 160.0, 'peso': 70.0, 'resultado': 27.34, 'classificacao': 'Sobrepeso'},
    ];

    for (final data in testData) {
      final altura = data['altura'] as double;
      final peso = data['peso'] as double;
      final resultadoEsperado = data['resultado'] as double;
      final classificacaoEsperada = data['classificacao'] as String;

      final resultadoCalculado = calcularIMC(altura, peso);
      final classificacaoCalculada = classificarIMC(resultadoCalculado);

      expect(resultadoCalculado, moreOrLessEquals(resultadoEsperado, epsilon: 0.1));
      expect(classificacaoCalculada, equals(classificacaoEsperada));
    }
  });
}
