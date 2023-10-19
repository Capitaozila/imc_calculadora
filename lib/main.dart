import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user_data_combined.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataCombinedAdapter());

  // Abra a caixa Hive
  await Hive.openBox<UserDataCombined>('user_data_combined_box');

  runApp(const ImcCalculadora());
}

class ImcCalculadora extends StatelessWidget {
  const ImcCalculadora({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF171717),
        primaryColor: const Color(0xFF2C3E50),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          backgroundColor: const Color(0xFF2C3E50),
        ),
        body: const CalculatorScreen(),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key});

  @override
  createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _nome = '';
  double _altura = 0.0;
  double _peso = 0.0;
  double _imcResultado = 0.0;
  String _classificacao = '';
  final List<double> _listaImc = [];
  final _userDataBox = Hive.box<UserDataCombined>('user_data_combined_box');

  @override
  void initState() {
    super.initState();
    final userDataCombined = _userDataBox.get('user_data_combined');

    if (userDataCombined != null) {
      _nome = userDataCombined.name;
      _altura = userDataCombined.height;
      _listaImc.addAll(userDataCombined.imcList);
    }
  }

  double calcularIMC(double altura, double peso) {
    double imc = peso / ((altura / 100) * (altura / 100));
    return double.parse(imc.toStringAsFixed(2));
  }

  String classificarIMC(double imc) {
    if (imc < 16) {
      return 'Magreza grave';
    } else if (imc >= 16 && imc < 17) {
      return 'Magreza moderada';
    } else if (imc >= 17 && imc < 18.5) {
      return 'Magreza leve';
    } else if (imc >= 18.5 && imc < 25) {
      return 'Saudável';
    } else if (imc >= 25 && imc < 30) {
      return 'Sobrepeso';
    } else if (imc >= 30 && imc < 35) {
      return 'Obesidade Grau I';
    } else if (imc >= 35 && imc < 40) {
      return 'Obesidade Grau II (severa)';
    } else {
      return 'Obesidade Grau III (mórbida)';
    }
  }

  final shadowStyle = BoxShadow(
    color: Colors.black.withOpacity(0.5),
    spreadRadius: 3,
    blurRadius: 5,
    offset: const Offset(0, 3),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Informe seus dados',
              style: TextStyle(
                fontSize: 20.0,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [shadowStyle],
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    _nome = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [shadowStyle],
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _altura = double.tryParse(value) ?? 0.0;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Altura (cm)',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [shadowStyle],
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _peso = double.tryParse(value) ?? 0.0;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _imcResultado = calcularIMC(_altura, _peso);
                  _classificacao = classificarIMC(_imcResultado);

                  // Salvar os dados no Hive
                  final userDataCombined = UserDataCombined(_nome, _altura, _listaImc);
                  _userDataBox.put('user_data_combined', userDataCombined);

                  _listaImc.add(_imcResultado);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: const Text(
                'Calcular IMC',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Olá $_nome! Seu IMC é: $_imcResultado',
              style: const TextStyle(
                fontSize: 20.0,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(
              'Classificação: $_classificacao',
              style: const TextStyle(
                fontSize: 20.0,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [shadowStyle],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _listaImc.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'IMC ${index + 1}: ${_listaImc[index]} um IMC ${classificarIMC(_listaImc[index])}!',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
