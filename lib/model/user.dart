class User {
  int? id;
  String? nome;
  String? senha;
  String? email;
  String? primeiraData;
  String? afterFoto;
  String? beforeFoto;
  String? segundaData;
  String? pathImage;

  User();

  User.fromJson(Map map) {
    id = map['id'];
    nome = map['name'];
    senha = map['senha'];
    email = map['email'];
    afterFoto = map['afterFoto'];
    beforeFoto = map['beforeFoto'];
    primeiraData = map['primeiraData'];
    segundaData = map['segundaData'];
    pathImage = map['pathImage'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['name'] = nome;
    map['email'] = email;
    map['senha'] = senha;
    map['afterFoto'] = afterFoto;
    map['beforeFoto'] = beforeFoto;
    map['primeiraData'] = primeiraData;
    map['segundaData'] = segundaData;
    map['pathImage'] = pathImage;
    return map;
  }
}
