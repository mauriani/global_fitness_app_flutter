import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/bmi_screen.dart';
import 'package:flutter_application_1/screens/intro_screen.dart';
import 'package:flutter_application_1/screens/weather_screen.dart';

import '../screens/sessions_screens.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    /** final é semelhante ao const do javascript */
    final List<String> menuTitles = [
      'Home',
      'BMI Calculator',
      'Weather',
      'Sessions'
    ];

    List<Widget> menuItems = [];
    menuItems.add(
      const DrawerHeader(
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: Text('Globo Fitness',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );

    for (var element in menuTitles) {
      Widget screen = Container();
      menuItems.add(ListTile(
        title: Text(element, style: const TextStyle(fontSize: 18)),
        onTap: () {
          switch (element) {
            case 'Home':
              screen = const IntroScreen();
              break;

            case 'BMI Calculator':
              screen = const BmiScreen();
              break;

            case 'Weather':
              screen = const WeatherScreen();
              break;

            case 'Sessions':
              screen = const SessionsScreen();
              break;
          }
          /** O pop remove todos da pilha de navegação */
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screen));
        },
      ));
    }

    return menuItems;
  }
}
