import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tcc/modules/home/models/meeting.dart';
import 'package:tcc/modules/home/models/tcc.dart';

import '../../../core/log/log_pattern.dart';
import '../../../core/services/api/db/db.dart';
import '../../../core/services/api/methods/methods_api.dart';

class ReunioesController extends ChangeNotifier {
  MethodsApi methods = MethodsApi();
  DB db = DB();
  LogPattern log = LogPattern();

  ValueNotifier<List<Tcc>> listTccs = ValueNotifier<List<Tcc>>([]);

  ValueNotifier<bool> openInfosReuniao = ValueNotifier<bool>(false);

  ValueNotifier<Tcc> selected = ValueNotifier<Tcc>(Tcc.empty());
  TextEditingController controllerTcc = TextEditingController();

  TextEditingController controllerData = TextEditingController();
  TextEditingController descricaoReuniao = TextEditingController();

  DateTime selectedDate = DateTime.now();

  ValueNotifier<bool> isCadastrarTcc = ValueNotifier<bool>(false);

  ValueNotifier<List<Meeting>> listReunioes = ValueNotifier<List<Meeting>>([]);
  ValueNotifier<bool> isLoadReunioes = ValueNotifier<bool>(true);
  ValueNotifier<Meeting> selectedReuniao = ValueNotifier<Meeting>(Meeting.empty());

  void openReuniao(Meeting reuniao) {
    selected.value = reuniao.tcc;
    selectedReuniao.value = reuniao;
    controllerData.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(reuniao.dataMeet));
    descricaoReuniao.text = reuniao.descricao;
    controllerTcc.text = reuniao.tcc.tema;
    openInfosReuniao.value = true;
  }

  Future<void> loadTccs() async {
    final res = await methods.getTccs(Supabase.instance.client.auth.currentUser!.email!);

    listTccs.value = [];
    if (res.isNotEmpty) {
      for (var item in res) {
        listTccs.value.add(Tcc.fromJson(item));
      }
    }
  }

  void clear() {
    openInfosReuniao.value = false;
    controllerData.clear();
    descricaoReuniao.clear();
    controllerTcc.clear();
    selectedDate = DateTime.now();
    selected.value = Tcc.empty();
  }

  Future<(bool status, String menssage)> addReuniao() async {
    if (selected.value.id != 0) {
      final res = await methods.addReuniao(
        idTcc: selected.value.id.toString(),
        dataMeet: selectedDate.toString().substring(0, 10),
        descricao: descricaoReuniao.text,
      );

      return res;
    } else if (controllerData.text.isEmpty) {
      return (false, 'Preencha a data');
    } else {
      return (false, 'Erro ao adicionar reunião');
    }
  }

  Future<void> loadReunioes() async {
    isLoadReunioes.value = true;

    final res = await methods.getReunioes(Supabase.instance.client.auth.currentUser!.email!);
    List<Meeting> listReunioesTemp = [];

    listReunioesTemp = [];
    if (res.isNotEmpty) {
      for (var item in res) {
        listReunioesTemp.add(Meeting.fromJson(item));
      }
    }

    for (var item in listReunioesTemp) {
      final res = await methods.getTcc(item.idTcc);
      if (res.isNotEmpty) {
        item.tcc = Tcc.fromJson(res[0]);
      }
    }

    listReunioes.value = [];
    listReunioes.value = listReunioesTemp;
    isLoadReunioes.value = false;
  }
}
