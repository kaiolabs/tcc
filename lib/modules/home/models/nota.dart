class Nota {
  int id;
  String comentario;
  String notaIntroducao;
  String notaRevisaoBibliograficaP1;
  String notaRevisaoBibliograficaP2;
  String notaOrientacaoMetodologicaP1;
  String notaOrientacaoMetodologicaP2;
  String notaDefinicaoObjetivos;
  String idTcc;
  String idAutor;
  String dataInclusao;
  String chamada;

  Nota({
    this.id = 0,
    this.comentario = '',
    this.notaIntroducao = '',
    this.notaRevisaoBibliograficaP1 = '',
    this.notaRevisaoBibliograficaP2 = '',
    this.notaOrientacaoMetodologicaP1 = '',
    this.notaOrientacaoMetodologicaP2 = '',
    this.notaDefinicaoObjetivos = '',
    this.idTcc = '',
    this.idAutor = '',
    this.dataInclusao = '',
    this.chamada = '',
  });

  factory Nota.fromJson(Map<String, dynamic> json) => Nota(
        id: json["id"] ?? 0,
        comentario: json["comentario"] ?? '',
        notaIntroducao: json["nota_introducao"] ?? '',
        notaRevisaoBibliograficaP1: json["nota_revisao_bibliografica_p1"] ?? '',
        notaRevisaoBibliograficaP2: json["nota_revisao_bibliografica_p2"] ?? '',
        notaOrientacaoMetodologicaP1: json["nota_orientacao_metodologica_p1"] ?? '',
        notaOrientacaoMetodologicaP2: json["nota_orientacao_metodologica_p2"] ?? '',
        notaDefinicaoObjetivos: json["nota_definicao_objetivos"] ?? '',
        idTcc: json["id_tcc"] ?? '',
        idAutor: json["id_autor"] ?? '',
        dataInclusao: json["data_inclusao"] ?? '',
        chamada: json["chamada"] ?? '',
      );

  factory Nota.empty() => Nota(
        id: 0,
        comentario: '',
        notaIntroducao: '',
        notaRevisaoBibliograficaP1: '',
        notaRevisaoBibliograficaP2: '',
        notaOrientacaoMetodologicaP1: '',
        notaOrientacaoMetodologicaP2: '',
        notaDefinicaoObjetivos: '',
        idTcc: '',
        idAutor: '',
        dataInclusao: '',
        chamada: '',
      );

  // calculo de nota o pesso total e 10 pontos
  // introducao tem peso 2
  // definicao de objetivos tem peso 1
  // notaRevisaoBibliograficaP1 tem peso 2
  // notaRevisaoBibliograficaP2 tem peso 1
  // notaOrientacaoMetodologicaP1 tem peso 2
  // notaOrientacaoMetodologicaP2 tem peso 2
  // cada topico vai de 0 a 10 pontos
  // nota final = (notaIntroducao * 2) + (notaRevisaoBibliograficaP1 * 2) + (notaRevisaoBibliograficaP2 * 1) + (notaOrientacaoMetodologicaP1 * 2) + (notaOrientacaoMetodologicaP2 * 2) + (notaDefinicaoObjetivos * 1) / 10

  double get notaFinal {
    double notaIntroducao = double.tryParse(this.notaIntroducao) ?? 0;
    double notaRevisaoBibliograficaP1 = double.tryParse(this.notaRevisaoBibliograficaP1) ?? 0;
    double notaRevisaoBibliograficaP2 = double.tryParse(this.notaRevisaoBibliograficaP2) ?? 0;
    double notaOrientacaoMetodologicaP1 = double.tryParse(this.notaOrientacaoMetodologicaP1) ?? 0;
    double notaOrientacaoMetodologicaP2 = double.tryParse(this.notaOrientacaoMetodologicaP2) ?? 0;
    double notaDefinicaoObjetivos = double.tryParse(this.notaDefinicaoObjetivos) ?? 0;

    double notaFinal = (((notaIntroducao * 2) +
            (notaRevisaoBibliograficaP1 * 2) +
            (notaRevisaoBibliograficaP2 * 1) +
            (notaOrientacaoMetodologicaP1 * 2) +
            (notaOrientacaoMetodologicaP2 * 2) +
            (notaDefinicaoObjetivos * 1)) /
        10);

    return notaFinal;
  }

  // nota string
  String get notaFinalString => notaFinal.toStringAsFixed(2);
}
