class Cronograma {
  final int id;
  final String dataEntregaTccInicio;
  final String dataEntregaTccFim;
  final String dataAvaliacaoTccInicio;
  final String dataAvaliacaoTccFim;
  final String dataSegundaChamadaInicio;
  final String dataSegundaChamadaFim;
  final String dataAvaliacaoSegundaChamadaInicio;
  final String dataAvaliacaoSegundaChamadaFim;
  final String dataTerceiraChamadaInicio;
  final String dataTerceiraChamadaFim;
  final String dataAvaliacaoTerceiraChamadaInicio;
  final String dataAvaliacaoTerceiraChamadaFim;

  Cronograma({
    this.id = 0,
    this.dataEntregaTccInicio = '',
    this.dataEntregaTccFim = '',
    this.dataAvaliacaoTccInicio = '',
    this.dataAvaliacaoTccFim = '',
    this.dataSegundaChamadaInicio = '',
    this.dataSegundaChamadaFim = '',
    this.dataAvaliacaoSegundaChamadaInicio = '',
    this.dataAvaliacaoSegundaChamadaFim = '',
    this.dataTerceiraChamadaInicio = '',
    this.dataTerceiraChamadaFim = '',
    this.dataAvaliacaoTerceiraChamadaInicio = '',
    this.dataAvaliacaoTerceiraChamadaFim = '',
  });

  factory Cronograma.fromJson(Map<String, dynamic> json) => Cronograma(
        id: json["id"] ?? 0,
        dataEntregaTccInicio: json["data_entrega_tcc_inicio"] ?? '',
        dataEntregaTccFim: json["data_entrega_tcc_fim"] ?? '',
        dataAvaliacaoTccInicio: json["data_avaliacao_tcc_inicio"] ?? '',
        dataAvaliacaoTccFim: json["data_avaliacao_tcc_fim"] ?? '',
        dataSegundaChamadaInicio: json["data_segunda_chamada_inicio"] ?? '',
        dataSegundaChamadaFim: json["data_segunda_chamada_fim"] ?? '',
        dataAvaliacaoSegundaChamadaInicio: json["data_avaliacao_segunda_chamada_inicio"] ?? '',
        dataAvaliacaoSegundaChamadaFim: json["data_avaliacao_segunda_chamada_fim"] ?? '',
        dataTerceiraChamadaInicio: json["data_terceira_chamada_inicio"] ?? '',
        dataTerceiraChamadaFim: json["data_terceira_chamada_fim"] ?? '',
        dataAvaliacaoTerceiraChamadaInicio: json["data_avaliacao_terceira_chamada_inicio"] ?? '',
        dataAvaliacaoTerceiraChamadaFim: json["data_avaliacao_terceira_chamada_fim"] ?? '',
      );

  factory Cronograma.empty() => Cronograma();

  //verifica se esta dentro do prazo de entrega do tcc
  bool get isEntregaTcc {
    if (dataEntregaTccInicio.isEmpty || dataEntregaTccFim.isEmpty) {
      return false;
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataEntregaTccInicio);
    final fim = DateTime.parse(dataEntregaTccFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return true;
    } else {
      return false;
    }
  }

  // mensagem de aviso que ele tem ate a data de entrega para entregar o tcc

  String get mensagemEntregaTcc {
    if (dataEntregaTccInicio.isEmpty || dataEntregaTccFim.isEmpty) {
      return '';
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataEntregaTccInicio);
    final fim = DateTime.parse(dataEntregaTccFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return 'Você tem até o dia ${fim.day}/${fim.month}/${fim.year} para entregar o TCC';
    } else {
      return '';
    }
  }

  //verifica se esta dentro do prazo de avaliação do tcc

  bool get isAvaliacaoTcc {
    if (dataAvaliacaoTccInicio.isEmpty || dataAvaliacaoTccFim.isEmpty) {
      return false;
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataAvaliacaoTccInicio);
    final fim = DateTime.parse(dataAvaliacaoTccFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return true;
    } else {
      return false;
    }
  }

  // mensagem de aviso que ele tem ate a data de entrega para entregar o tcc

  String get mensagemAvaliacaoTcc {
    if (dataAvaliacaoTccInicio.isEmpty || dataAvaliacaoTccFim.isEmpty) {
      return '';
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataAvaliacaoTccInicio);
    final fim = DateTime.parse(dataAvaliacaoTccFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return 'Você tem até o dia ${fim.day}/${fim.month}/${fim.year} para avaliar o TCC';
    } else {
      return '';
    }
  }

  //verifica se esta dentro do prazo de segunda chamada do tcc

  bool get isSegundaChamada {
    if (dataSegundaChamadaInicio.isEmpty || dataSegundaChamadaFim.isEmpty) {
      return false;
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataSegundaChamadaInicio);
    final fim = DateTime.parse(dataSegundaChamadaFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return true;
    } else {
      return false;
    }
  }

  // mensagem de aviso que ele tem ate a data de entrega para entregar o tcc

  String get mensagemSegundaChamada {
    if (dataSegundaChamadaInicio.isEmpty || dataSegundaChamadaFim.isEmpty) {
      return '';
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataSegundaChamadaInicio);
    final fim = DateTime.parse(dataSegundaChamadaFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return 'Você tem até o dia ${fim.day}/${fim.month}/${fim.year} para entregar o TCC na segunda chamada.';
    } else {
      return '';
    }
  }

  //verifica se esta dentro do prazo de avaliação da segunda chamada do tcc

  bool get isAvaliacaoSegundaChamada {
    if (dataAvaliacaoSegundaChamadaInicio.isEmpty || dataAvaliacaoSegundaChamadaFim.isEmpty) {
      return false;
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataAvaliacaoSegundaChamadaInicio);
    final fim = DateTime.parse(dataAvaliacaoSegundaChamadaFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return true;
    } else {
      return false;
    }
  }

  // mensagem de aviso que ele tem ate a data de entrega para entregar o tcc

  String get mensagemAvaliacaoSegundaChamada {
    if (dataAvaliacaoSegundaChamadaInicio.isEmpty || dataAvaliacaoSegundaChamadaFim.isEmpty) {
      return '';
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataAvaliacaoSegundaChamadaInicio);
    final fim = DateTime.parse(dataAvaliacaoSegundaChamadaFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return 'Você tem até o dia ${fim.day}/${fim.month}/${fim.year} para avaliar o TCC na segunda chamada.';
    } else {
      return '';
    }
  }

  //verifica se esta dentro do prazo de terceira chamada do tcc

  bool get isTerceiraChamada {
    if (dataTerceiraChamadaInicio.isEmpty || dataTerceiraChamadaFim.isEmpty) {
      return false;
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataTerceiraChamadaInicio);
    final fim = DateTime.parse(dataTerceiraChamadaFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return true;
    } else {
      return false;
    }
  }

  // mensagem de aviso que ele tem ate a data de entrega para entregar o tcc

  String get mensagemTerceiraChamada {
    if (dataTerceiraChamadaInicio.isEmpty || dataTerceiraChamadaFim.isEmpty) {
      return '';
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataTerceiraChamadaInicio);
    final fim = DateTime.parse(dataTerceiraChamadaFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return 'Você tem até o dia ${fim.day}/${fim.month}/${fim.year} para entregar o TCC na terceira chamada.';
    } else {
      return '';
    }
  }

  //verifica se esta dentro do prazo de avaliação da terceira chamada do tcc

  bool get isAvaliacaoTerceiraChamada {
    if (dataAvaliacaoTerceiraChamadaInicio.isEmpty || dataAvaliacaoTerceiraChamadaFim.isEmpty) {
      return false;
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataAvaliacaoTerceiraChamadaInicio);
    final fim = DateTime.parse(dataAvaliacaoTerceiraChamadaFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return true;
    } else {
      return false;
    }
  }

  // mensagem de aviso que ele tem ate a data de entrega para entregar o tcc

  String get mensagemAvaliacaoTerceiraChamada {
    if (dataAvaliacaoTerceiraChamadaInicio.isEmpty || dataAvaliacaoTerceiraChamadaFim.isEmpty) {
      return '';
    }

    final now = DateTime.now();
    final inicio = DateTime.parse(dataAvaliacaoTerceiraChamadaInicio);
    final fim = DateTime.parse(dataAvaliacaoTerceiraChamadaFim);

    if (now.isAfter(inicio) && now.isBefore(fim)) {
      return 'Você tem até o dia ${fim.day}/${fim.month}/${fim.year} para avaliar o TCC na terceira chamada.';
    } else {
      return '';
    }
  }

  // vai pegar a data atual e verificar se esta dentro do prazo de entrega do tcc da primeira chamada ou segunda ou terceira chamada ou terceira chamada

  String get mensagemEntregaTccAtual {
    if (isEntregaTcc) {
      return mensagemEntregaTcc;
    } else if (isSegundaChamada) {
      return mensagemSegundaChamada;
    } else if (isTerceiraChamada) {
      return mensagemTerceiraChamada;
    } else {
      return '';
    }
  }

  // vai pegar a data atual e verificar se esta dentro do prazo de avaliação do tcc da primeira chamada ou segunda ou terceira chamada ou terceira chamada

  String get mensagemAvaliacaoTccAtual {
    if (isAvaliacaoTcc) {
      return mensagemAvaliacaoTcc;
    } else if (isAvaliacaoSegundaChamada) {
      return mensagemAvaliacaoSegundaChamada;
    } else if (isAvaliacaoTerceiraChamada) {
      return mensagemAvaliacaoTerceiraChamada;
    } else {
      return '';
    }
  }
}
