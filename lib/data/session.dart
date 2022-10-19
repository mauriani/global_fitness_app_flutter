class Session {
  int id = 0;
  String date = "";
  String description = "";
  int duration = 0;

  Session(this.id, this.date, this.description, this.duration);

  // outro construtor para dados que venha em json e transforme em array

  Session.fromJSON(Map<String, dynamic> sessionMap) {
    id = sessionMap['id'] ?? 0;
    date = sessionMap['date'] ?? '';
    description = sessionMap['description'] ?? '';
    duration = sessionMap['duration'] ?? 0;
  }

  // vamos fazer o contrario do anterior

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'description': description,
      'duration': duration,
    };
  }
}
