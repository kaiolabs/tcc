import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/log/log_pattern.dart';
import '../../../core/services/api/db/db.dart';
import '../../../core/services/api/methods/methods_api.dart';

class ConfigsController extends ChangeNotifier {
  MethodsApi methods = MethodsApi();
  DB db = DB();
  LogPattern log = LogPattern();

  DateTime dataEntregaTccInicio = DateTime.now();
  DateTime dataEntregaTccFim = DateTime.now();

  TextEditingController dataEntregaTccInicioController = TextEditingController();
  TextEditingController dataEntregaTccFimController = TextEditingController();

  //=================================================================================================

  DateTime dataAvaliacaoTccInicio = DateTime.now();
  DateTime dataAvaliacaoTccFim = DateTime.now();

  TextEditingController dataAvaliacaoTccInicioController = TextEditingController();
  TextEditingController dataAvaliacaoTccFimController = TextEditingController();

  //=================================================================================================

  DateTime dataSegundaChamadaInicio = DateTime.now();
  DateTime dataSegundaChamadaFim = DateTime.now();

  TextEditingController dataSegundaChamadaInicioController = TextEditingController();
  TextEditingController dataSegundaChamadaFimController = TextEditingController();

  //=================================================================================================

  DateTime dataAvaliacaoSegundaChamadaInicio = DateTime.now();
  DateTime dataAvaliacaoSegundaChamadaFim = DateTime.now();

  TextEditingController dataAvaliacaoSegundaChamadaInicioController = TextEditingController();
  TextEditingController dataAvaliacaoSegundaChamadaFimController = TextEditingController();

  //=================================================================================================

  DateTime dataTerceiraChamadaInicio = DateTime.now();
  DateTime dataTerceiraChamadaFim = DateTime.now();

  TextEditingController dataTerceiraChamadaInicioController = TextEditingController();
  TextEditingController dataTerceiraChamadaFimController = TextEditingController();

  //=================================================================================================

  DateTime dataAvaliacaoTerceiraChamadaInicio = DateTime.now();
  DateTime dataAvaliacaoTerceiraChamadaFim = DateTime.now();

  TextEditingController dataAvaliacaoTerceiraChamadaInicioController = TextEditingController();
  TextEditingController dataAvaliacaoTerceiraChamadaFimController = TextEditingController();

  //=================================================================================================

  ValueNotifier<bool> loading = ValueNotifier<bool>(false);

  Future<(bool, String)> saveConfigs() async {
    try {
      await methods.put(
        table: db.cronograma,
        body: {
          'data_entrega_tcc_inicio': dataEntregaTccInicio.toString().substring(0, 16),
          'data_entrega_tcc_fim': dataEntregaTccFim.toString().substring(0, 16),
          'data_avaliacao_tcc_inicio': dataAvaliacaoTccInicio.toString().substring(0, 16),
          'data_avaliacao_tcc_fim': dataAvaliacaoTccFim.toString().substring(0, 16),
          'data_segunda_chamada_inicio': dataSegundaChamadaInicio.toString().substring(0, 16),
          'data_segunda_chamada_fim': dataSegundaChamadaFim.toString().substring(0, 16),
          'data_avaliacao_segunda_chamada_inicio': dataAvaliacaoSegundaChamadaInicio.toString().substring(0, 16),
          'data_avaliacao_segunda_chamada_fim': dataAvaliacaoSegundaChamadaFim.toString().substring(0, 16),
          'data_terceira_chamada_inicio': dataTerceiraChamadaInicio.toString().substring(0, 16),
          'data_terceira_chamada_fim': dataTerceiraChamadaFim.toString().substring(0, 16),
          'data_avaliacao_terceira_chamada_inicio': dataAvaliacaoTerceiraChamadaInicio.toString().substring(0, 16),
          'data_avaliacao_terceira_chamada_fim': dataAvaliacaoTerceiraChamadaFim.toString().substring(0, 16),
        },
        filter: {
          'id': '1',
        },
      );

      return (true, 'Sucesso, configurações salvas!');
    } on PostgrestException catch (state, e) {
      log.e('Erro ao salvar configurações: $e');
      return (false, 'Erro ao salvar configurações');
    }
  }

  // get configs
  Future<void> getConfigs() async {
    try {
      loading.value = true;
      final response = await methods.get(
        table: db.cronograma,
        filter: {
          'id': '1',
        },
      );
      if (response.isNotEmpty) {
        dataEntregaTccInicio = DateTime.parse(response[0]['data_entrega_tcc_inicio']);
        dataEntregaTccFim = DateTime.parse(response[0]['data_entrega_tcc_fim']);
        dataAvaliacaoTccInicio = DateTime.parse(response[0]['data_avaliacao_tcc_inicio']);
        dataAvaliacaoTccFim = DateTime.parse(response[0]['data_avaliacao_tcc_fim']);
        dataSegundaChamadaInicio = DateTime.parse(response[0]['data_segunda_chamada_inicio']);
        dataSegundaChamadaFim = DateTime.parse(response[0]['data_segunda_chamada_fim']);
        dataAvaliacaoSegundaChamadaInicio = DateTime.parse(response[0]['data_avaliacao_segunda_chamada_inicio']);
        dataAvaliacaoSegundaChamadaFim = DateTime.parse(response[0]['data_avaliacao_segunda_chamada_fim']);
        dataTerceiraChamadaInicio = DateTime.parse(response[0]['data_terceira_chamada_inicio']);
        dataTerceiraChamadaFim = DateTime.parse(response[0]['data_terceira_chamada_fim']);
        dataAvaliacaoTerceiraChamadaInicio = DateTime.parse(response[0]['data_avaliacao_terceira_chamada_inicio']);
        dataAvaliacaoTerceiraChamadaFim = DateTime.parse(response[0]['data_avaliacao_terceira_chamada_fim']);

        dataEntregaTccInicioController.text = DateFormat('dd/MM/yyyy').format(dataEntregaTccInicio);
        dataEntregaTccFimController.text = DateFormat('dd/MM/yyyy').format(dataEntregaTccFim);
        dataAvaliacaoTccInicioController.text = DateFormat('dd/MM/yyyy').format(dataAvaliacaoTccInicio);
        dataAvaliacaoTccFimController.text = DateFormat('dd/MM/yyyy').format(dataAvaliacaoTccFim);
        dataSegundaChamadaInicioController.text = DateFormat('dd/MM/yyyy').format(dataSegundaChamadaInicio);
        dataSegundaChamadaFimController.text = DateFormat('dd/MM/yyyy').format(dataSegundaChamadaFim);
        dataAvaliacaoSegundaChamadaInicioController.text = DateFormat('dd/MM/yyyy').format(dataAvaliacaoSegundaChamadaInicio);
        dataAvaliacaoSegundaChamadaFimController.text = DateFormat('dd/MM/yyyy').format(dataAvaliacaoSegundaChamadaFim);
        dataTerceiraChamadaInicioController.text = DateFormat('dd/MM/yyyy').format(dataTerceiraChamadaInicio);
        dataTerceiraChamadaFimController.text = DateFormat('dd/MM/yyyy').format(dataTerceiraChamadaFim);
        dataAvaliacaoTerceiraChamadaInicioController.text = DateFormat('dd/MM/yyyy').format(dataAvaliacaoTerceiraChamadaInicio);
        dataAvaliacaoTerceiraChamadaFimController.text = DateFormat('dd/MM/yyyy').format(dataAvaliacaoTerceiraChamadaFim);
      }
      loading.value = false;
    } on PostgrestException catch (e) {
      log.e('Erro ao buscar configurações: $e');
      loading.value = false;
    }
  }
}
