import 'dart:io';

void main() {
  final scanner = stdin;

  // Solicitar a entrada do usuário
  // print("Por favor, forneça os valores no formato 'data,hora,descricao,valor':");
  final entrada = scanner.readLineSync()!;

  // Dividir a entrada em partes
  final partes = entrada.split(',');

  // Verificar se a entrada contém exatamente 4 partes
  if (partes.length != 4) {
    print("Entrada inválida. Certifique-se de fornecer 4 valores separados por vírgulas.");
    return;
  }

  // Extrair os valores e criar uma instância de Transacao
  final data = partes[0];
  final hora = partes[1];
  final descricao = partes[2];
  final valor = double.tryParse(partes[3]);

  if (valor == null) {
    print("Valor inválido. Certifique-se de que o quarto valor seja um número válido.");
    return;
  }

  final transacao = Transacao(data, hora, descricao, valor);

  // Imprimir a transação
  transacao.imprimir();
}

class Transacao {
  final String data;
  final String hora;
  final String descricao;
  final double valor;

  Transacao(this.data, this.hora, this.descricao, this.valor);

  void imprimir() {
    print(descricao);
    print(data);
    print(hora);
    print(valor.toStringAsFixed(2));
  }
}
