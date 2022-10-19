import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Globo Fitness')),
      drawer: const MenuDrawer(),
      bottomNavigationBar: const MenuBottom(),
      body: Container(
        // imagem de fundo
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image.jpg'), fit: BoxFit.cover)),
        child: Center(
          child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Text("Bem vindo ao \nGlobo fitness!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, shadows: [
                    Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Colors.grey)
                  ]))),
        ),
      ),
    );
  }
}
