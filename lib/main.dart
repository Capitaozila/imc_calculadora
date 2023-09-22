import 'package:flutter/material.dart';

void main() {
  runApp(const ImcCalculadora());
}

class ImcCalculadora extends StatelessWidget {
  const ImcCalculadora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
        ),
        body: const CalculatorScreen(),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _nome = '';
  double _altura = 0.0;
  double _peso = 0.0;
  double _imcResultado = 0.0;
  String _classificacao = '';

  double calcularIMC(double altura, double peso) {
    double imc = peso / ((altura / 100) * (altura / 100));
    return double.parse(imc.toStringAsFixed(2));
  }

  String classificarIMC(double imc) {
    if (imc < 16) {
      return "Magreza grave";
    } else if (imc >= 16 && imc < 17) {
      return "Magreza moderada";
    } else if (imc >= 17 && imc < 18.5) {
      return "Magreza leve";
    } else if (imc >= 18.5 && imc < 25) {
      return "Saudável";
    } else if (imc >= 25 && imc < 30) {
      return "Sobrepeso";
    } else if (imc >= 30 && imc < 35) {
      return "Obesidade Grau I";
    } else if (imc >= 35 && imc < 40) {
      return "Obesidade Grau II (severa)";
    } else {
      return "Obesidade Grau III (mórbida)";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Use SingleChildScrollView para permitir a rolagem
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Informe seus dados',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _nome = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _altura = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Altura (cm)',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _peso = double.tryParse(value) ?? 0.0;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _imcResultado = calcularIMC(_altura, _peso);
                  _classificacao = classificarIMC(_imcResultado);
                });
              },
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Olá $_nome! Seu IMC é: $_imcResultado',
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              'Classificação: $_classificacao',
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
