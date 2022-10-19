import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/bmi_screen.dart';
import 'package:flutter_application_1/screens/intro_screen.dart';

/*ESTE É O PONTO DE ENTRADA DE UM APLICATIVO FLUTTER*/
void main() {
  runApp(const GlobeApp());
}

class GlobeApp extends StatelessWidget {
  const GlobeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      routes: {
        '/': (context) => const IntroScreen(),
        '/bmi': (context) => const BmiScreen()
      },
      initialRoute: '/',
    );
  }
}
