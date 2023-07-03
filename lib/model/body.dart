class Body {
  int? id;
  int? userid;
  String? kilogramas;
  String? age;
  String? muscle;
  String? bone;
  String? bodyFat;
  String? bmi;
  String? kcal;
  String? water;
  String? visceral;
  String? coxa;
  String? biceps;
  String? triceps;
  String? peito;
  String? panturrilha;
  String? cintura;
  Body();
  Body.fromJson(Map map) {
    id = map['id'];
    userid = map['iduser'];
    kilogramas = map['kilogramas'] ?? '0';
    age = map['age'] ?? '0';
    bone = map['bone'] ?? '0';
    bodyFat = map['body'] ?? '0';
    muscle = map['muscle'] ?? '0';
    bmi = map['bmi'] ?? '0';
    kcal = map['kcal'] ?? '0';
    water = map['water'] ?? '0';
    visceral = map['visceral'] ?? '0';
    coxa = map['coxa'] ?? '0';
    biceps = map['biceps'] ?? '0';
    triceps = map['triceps'] ?? '0';
    peito = map['peito'] ?? '0';
    panturrilha = map['panturrilha'] ?? '0';
    cintura = map['cintura'] ?? '0';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['id'] = id;
    map['kilogramas'] = kilogramas;
    map['iduser'] = userid;
    map['age'] = age;
    map['bone'] = bone;
    map['body'] = bodyFat;
    map['muscle'] = muscle;
    map['bmi'] = bmi;
    map['kcal'] = kcal;
    map['water'] = water;
    map['visceral'] = visceral;
    map['coxa'] = coxa;
    map['biceps'] = biceps;
    map['triceps'] = triceps;
    map['peito'] = peito;
    map['panturrilha'] = panturrilha;
    map['cintura'] = cintura;

    return map;
  }
}
