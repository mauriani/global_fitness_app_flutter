import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/menu_bottom.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  // controles de textField

  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWidth = TextEditingController();

  String heightMessage = '';
  String widthMessage = '';

  final double fontSize = 18;
  String result = '';
  bool isMetric = true;
  bool isImperial = false;

// Dessa forma digo ao flutter que realmente desejo que o peso e altura sejam nulos
  double? height;
  double? weight;

  late List<bool> isSelected;

// INICIANDO O ESTADO
  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMessage =
        'Por favor, informe sua altura em ${isMetric ? 'metros' : 'polegadas'}';
    widthMessage =
        'Por favor, informe seu peso em ${(isImperial) ? 'kilos' : 'libras'}';

    return Scaffold(
        appBar: AppBar(title: const Text('BMI Calculator')),
        bottomNavigationBar: const MenuBottom(),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: ToggleButtons(
                isSelected: isSelected,
                onPressed: toggleMeasure,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Metric', style: TextStyle(fontSize: fontSize)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child:
                        Text('Imperial', style: TextStyle(fontSize: fontSize)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: TextField(
                  controller: txtHeight,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: heightMessage,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: TextField(
                  controller: txtWidth,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: widthMessage,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                onPressed: findBMI,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 15),
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: const Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Container(height: 15),
            Text(result,
                style: TextStyle(color: Colors.black, fontSize: fontSize))
          ]),
        ));
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
    } else {
      isMetric = false;
      isImperial = true;
    }

    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }

  void findBMI() {
    double bmi = 0;

    // pega um string e passa para double
    double height = double.tryParse(txtHeight.text) ?? 0;
    double width = double.tryParse(txtWidth.text) ?? 0;

    if (isMetric) {
      bmi = width / (height * height);
    } else {
      bmi = width * 703 / (height * height);
    }

    setState(() {
      result = 'Seu imc é ${bmi.toStringAsFixed(2)}';
    });
  }
}
