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
  double _altura = 0.0;
  double _peso = 0.0;
  double _imc_resultado = 0.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Informe seus dados',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _altura = double.tryParse(value) ?? 0.0;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Altura(cm)',
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
                _imc_resultado = calcularIMC(_altura, _peso);
              });
            },
            child: const Text('Calcular Imc'),
          ),
          const SizedBox(height: 20.0),
          Text(
            'Seu IMC: $_imc_resultado',
            style: const TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
