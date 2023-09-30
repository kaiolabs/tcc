import 'package:tcc/modules/home/models/nota.dart';
import 'package:tcc/modules/home/models/user.dart';

class Tcc {
  int id;
  String aluno;
  String dataCadastro;
  String tema;
  String link;
  String cordenador;
  String orientador;
  String coorientador;
  String status;
  String notaFinal;
  String banca;
  String bancaNomes;
  String nomeCordenador;
  String nomeOrientador;
  String nomeCoorientador;
  String nomeAluno;
  String banca1;
  String banca2;
  String idAvaliadores;

  Nota notaOrientado = Nota.empty();
  Nota notaBanca1 = Nota.empty();
  Nota notaBanca2 = Nota.empty();

  String get notaFinalTccString => ((notaOrientado.notaFinal + notaBanca1.notaFinal + notaBanca2.notaFinal) / 3).toStringAsFixed(2);

  bool get isAprovado => double.parse(notaFinalTccString) >= 7;

  bool isNotaFinalComplet() {
    if (notaOrientado.notaIntroducao.isNotEmpty && notaBanca1.notaIntroducao.isNotEmpty && notaBanca2.notaIntroducao.isNotEmpty) {
      return true;
    }
    return false;
  }

  ClientApp banca1Client = ClientApp.empty();
  ClientApp banca2Client = ClientApp.empty();

  Tcc({
    this.id = 0,
    this.aluno = '',
    this.dataCadastro = '',
    this.tema = '',
    this.link = '',
    this.cordenador = '',
    this.orientador = '',
    this.coorientador = '',
    this.status = '',
    this.notaFinal = '',
    this.banca = '',
    this.bancaNomes = 'Banca não definida',
    this.nomeCordenador = 'Sem cordenador',
    this.nomeOrientador = 'Sem orientador',
    this.nomeCoorientador = 'Sem coorientador',
    this.nomeAluno = 'Sem aluno',
    this.banca1 = '',
    this.banca2 = '',
    this.idAvaliadores = '',
  });

  factory Tcc.fromJson(Map<String, dynamic> json) => Tcc(
        id: json["id"] ?? 0,
        aluno: json["aluno"] ?? '',
        dataCadastro: json["data_cadastro"] ?? '',
        tema: json["tema"] ?? '',
        link: json["link"] ?? '',
        cordenador: json["cordenador"] ?? '',
        orientador: json["orientador"] ?? '',
        coorientador: json["coorientador"] ?? '',
        status: json["status"] ?? '',
        notaFinal: json["nota_final"] ?? '',
        banca: json["banca"] ?? '',
        bancaNomes: json["banca_nomes"] ?? '',
        nomeCordenador: json["nome_cordenador"] ?? '',
        nomeOrientador: json["nome_orientador"] ?? '',
        nomeCoorientador: json["nome_coorientador"] ?? '',
        nomeAluno: json["nome_aluno"] ?? '',
        banca1: json["banca1"] ?? '',
        banca2: json["banca2"] ?? '',
        idAvaliadores: json["id_avaliadores"] ?? '',
      );

  factory Tcc.empty() => Tcc(
        id: 0,
        aluno: '',
        dataCadastro: '',
        tema: '',
        link: '',
        cordenador: '',
        orientador: '',
        coorientador: '',
        status: '',
        notaFinal: '',
        banca: '',
        bancaNomes: '',
        nomeCordenador: '',
        nomeOrientador: '',
        nomeCoorientador: '',
        nomeAluno: '',
        banca1: '',
        banca2: '',
        idAvaliadores: '',
      );

  String statusTcc() {
    switch (status) {
      case 'A':
        return 'Aguardando aprovação';
      case 'B':
        return 'Em avaliação pela banca';
      case 'C':
        return 'Concluído';
      case 'R':
        return 'Reprovado';
      default:
        return 'Aguardando';
    }
  }
}
