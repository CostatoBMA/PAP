class Task {
  int? id;
  int? userid;
  String? nome;
  int? status;
  String? date;

  Task();

  Task.fromJson(Map map) {
    id = map['id'];
    userid = map['iduser'];
    nome = map['name'];
    status = map['status'];
    date = map['inicio'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['name'] = nome;
    map['iduser'] = userid;
    map['status'] = status;
    map['inicio'] = date;
    return map;
  }
}
