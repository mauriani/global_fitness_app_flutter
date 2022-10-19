import 'package:shared_preferences/shared_preferences.dart';
import 'session.dart';
import 'dart:convert';

// objetivo e que funcione como interface entre a classe de session e no preferences
class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

// metodo de inserir
  Future writeSession(Session session) async {
    prefs.setString(session.id.toString(), json.encode(session.toJson()));
  }

  // get sessions

  List<Session> getSessions() {
    List<Session> sessions = [];
    Set<String> Keys = prefs.getKeys();
    for (var key in Keys) {
      if (key != 'counter') {
        Session session =
            Session.fromJSON(json.decode(prefs.getString(key) ?? ''));
        sessions.add(session);
      }
    }
    return sessions;
  }

  // metodo para lidar com o id increment

  Future setCounter() async {
    int counter = prefs.getInt('counter') ?? 0;
    counter++;

    await prefs.setInt('counter', counter);
  }

  // as leituras não são assincronas e ele retornaram em inteiro e nossa lista só comporta string

  int getCounter() {
    return prefs.getInt('counter') ?? 0;
  }

  Future deleteSession(int id) async {
    prefs.remove(id.toString());
  }
}
