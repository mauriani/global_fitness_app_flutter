import 'package:flutter/material.dart';
import '../data/session.dart';
import '../data/sp_helper.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  List<Session> sessions = [];
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDuration = TextEditingController();
  final SPHelper helper = SPHelper();

  @override
  void initState() {
    helper.init().then((value) => {updateScreen()});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sessions')),
      body: ListView(children: getContent()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSessionDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Inserir sessão de treinamento'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: TextField(
                          controller: txtDescription,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Descrição',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: TextField(
                          controller: txtDuration,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Duração',
                          )),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      txtDescription.text = '';
                      txtDuration.text = '';
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: saveSession, child: const Text('Salvar'))
              ]);
        });
  }

  Future saveSession() async {
    DateTime now = DateTime.now();
    String today = '${now.year} ${now.month} ${now.day}';
    int id = helper.getCounter() + 1;

// depois de escrever vamos atualizar
    Session newSession = Session(
        id, today, txtDescription.text, int.tryParse(txtDuration.text) ?? 0);
    helper.writeSession(newSession).then((_) {
      updateScreen();
      helper.setCounter();
    });

    txtDuration.text = '';
    txtDescription.text = '';
    Navigator.pop(context);
  }

  List<Widget> getContent() {
    List<Widget> tiles = [];
    for (var session in sessions) {
      {
        tiles.add(Dismissible(
          key: UniqueKey(),
          onDismissed: (_) {
            helper.deleteSession(session.id).then((value) => updateScreen());
          },
          child: ListTile(
            title: Text(session.description),
            subtitle:
                Text('${session.date} - duration: ${session.duration} min'),
          ),
        ));
      }
    }
    return tiles;
  }

  void updateScreen() {
    sessions = helper.getSessions();
    setState(() {});
  }
}
