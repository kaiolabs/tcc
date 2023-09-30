import 'package:tcc/modules/home/models/tcc.dart';

class Meeting {
  int id;
  String dataMeet;
  String idTcc;
  String idUser;
  String descricao;
  String permissoes;

  Tcc tcc = Tcc.empty();

  Meeting({
    this.id = 0,
    this.dataMeet = '',
    this.idTcc = '',
    this.idUser = '',
    this.descricao = '',
    this.permissoes = '',
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'] ?? 0,
      dataMeet: json['data_meet'] ?? '',
      idTcc: json['id_tcc'] ?? '',
      idUser: json['id_user'] ?? '',
      descricao: json['descricao'] ?? '',
      permissoes: json['permissoes'] ?? '',
    );
  }

  factory Meeting.empty() {
    return Meeting(
      id: 0,
      dataMeet: '',
      idTcc: '',
      idUser: '',
      descricao: '',
      permissoes: '',
    );
  }
}
