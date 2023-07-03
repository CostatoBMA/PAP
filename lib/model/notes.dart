class Notes {
  int? id;
  int? userid;
  String? nome;
  String? checkList;
  int? pinned;
  bool? click;
  String? date;

  Notes({click = false});

  Notes.fromJson(Map map) {
    id = map['id'];
    userid = map['iduser'];
    nome = map['name'];
    checkList = map['checkList'];
    pinned = map['pinned'];
    date = map['inicio'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['name'] = nome;
    map['checkList'] = checkList;
    map['iduser'] = userid;
    map['pinned'] = pinned;
    map['inicio'] = date;
    return map;
  }
}
