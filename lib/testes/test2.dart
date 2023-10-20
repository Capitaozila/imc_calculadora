import 'dart:io';

abstract class Cofre {
  final String tipo;
  final String metodoAbertura;

  Cofre(this.tipo, this.metodoAbertura);

  void imprimirInformacoes() {
    print('Tipo: $tipo');
    print('Metodo de abertura: $metodoAbertura');
  }
}

class CofreDigital extends Cofre {
  final int senha;

  CofreDigital(this.senha) : super('Cofre Digital', 'Senha');

  bool validarSenha(int confirmacaoSenha) {
    return confirmacaoSenha == senha;
  }
}

class CofreFisico extends Cofre {
  CofreFisico() : super('Cofre Fisico', 'Chave');
}

void main() {
  // stdout.write('Digite o tipo de cofre: ');
  final tipoCofre = stdin.readLineSync();

  if (tipoCofre?.toLowerCase() == 'digital') {
    // stdout.write('Digite a senha: ');
    final senha = int.tryParse(stdin.readLineSync() ?? '');
    // stdout.write('Digite a senha novamente: ');
    final confirmacaoSenha = int.tryParse(stdin.readLineSync() ?? '');

    if (senha != null && confirmacaoSenha != null) {
      final cofre = CofreDigital(senha);
      cofre.imprimirInformacoes();

      if (cofre.validarSenha(confirmacaoSenha)) {
        print('Cofre aberto!');
      } else {
        print('Senha incorreta!');
      }
    }
  }

  if (tipoCofre?.toLowerCase() == 'fisico') {
    final cofre = CofreFisico();
    cofre.imprimirInformacoes();
  }
}
