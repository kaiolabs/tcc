import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tcc/modules/home/models/nota.dart';
import 'package:tcc/modules/home/models/tcc.dart';

import '../../../core/log/log_pattern.dart';
import '../../../core/services/api/db/db.dart';
import '../../../core/services/api/methods/methods_api.dart';
import '../models/user.dart';
import 'home_controller.dart';

class AvaliacoesController extends ChangeNotifier {
  MethodsApi methods = MethodsApi();
  DB db = DB();
  LogPattern log = LogPattern();

  ValueNotifier<bool> isLoad = ValueNotifier<bool>(true);
  ValueNotifier<Tcc> tccSelected = ValueNotifier<Tcc>(Tcc.empty());
  ValueNotifier<bool> openInfosReuniao = ValueNotifier<bool>(false);
  ValueNotifier<List<Tcc>> listTccs = ValueNotifier<List<Tcc>>([]);

  TextEditingController notaIntroducao = TextEditingController();
  TextEditingController notaRevisaoBibliograficaP1 = TextEditingController();
  TextEditingController notaRevisaoBibliograficaP2 = TextEditingController();
  TextEditingController notaOrientacaoMetodologicaP1 = TextEditingController();
  TextEditingController notaOrientacaoMetodologicaP2 = TextEditingController();
  TextEditingController notaDefinicaoObjetivos = TextEditingController();
  TextEditingController notaConsideracoesFinais = TextEditingController();

  Future<void> loadTccs() async {
    HomeController homeController = Modular.get<HomeController>();

    final res = await methods.getTccsAvaliacao(Supabase.instance.client.auth.currentUser!.email!);

    isLoad.value = true;

    listTccs.value = [];
    if (res.isNotEmpty) {
      for (var item in res) {
        listTccs.value.add(Tcc.fromJson(item));
      }
    }

    for (final tcc in listTccs.value) {
      String idBanca1 = tcc.banca1;
      String idBanca2 = tcc.banca2;

      if (idBanca1.isNotEmpty) {
        final res = await methods.get(table: db.users, filter: {'email': idBanca1});
        if (res.isNotEmpty) {
          tcc.banca1Client = ClientApp.fromJson(res[0]);
        }
      }

      if (idBanca2.isNotEmpty) {
        final res = await methods.get(table: db.users, filter: {'email': idBanca2});
        if (res.isNotEmpty) {
          tcc.banca2Client = ClientApp.fromJson(res[0]);
        }
      }

      if (tcc.cordenador.isNotEmpty) {
        final res = await methods.getNotaOrientador(tcc.id.toString(), tcc.orientador);
        if (res.isNotEmpty) {
          tcc.notaOrientado = Nota.fromJson(res[0]);
        }
      }

      if (tcc.banca1.isNotEmpty) {
        final res = await methods.getNotaBanca1(tcc.id.toString(), tcc.banca1);
        if (res.isNotEmpty) {
          tcc.notaBanca1 = Nota.fromJson(res[0]);
        }
      }

      if (tcc.banca2.isNotEmpty) {
        final res = await methods.getNotaBanca2(tcc.id.toString(), tcc.banca2);
        if (res.isNotEmpty) {
          tcc.notaBanca2 = Nota.fromJson(res[0]);
        }
      }
    }

    isLoad.value = false;
  }

  Future<(bool status, String message)> addAvaliacao() async {
    final res = await methods.addAvaliacao(
      nota: Nota(
        notaIntroducao: notaIntroducao.text,
        notaRevisaoBibliograficaP1: notaRevisaoBibliograficaP1.text,
        notaRevisaoBibliograficaP2: notaRevisaoBibliograficaP2.text,
        notaOrientacaoMetodologicaP1: notaOrientacaoMetodologicaP1.text,
        notaOrientacaoMetodologicaP2: notaOrientacaoMetodologicaP2.text,
        notaDefinicaoObjetivos: notaDefinicaoObjetivos.text,
        idAutor: Supabase.instance.client.auth.currentUser!.id,
        idTcc: tccSelected.value.id.toString(),
        comentario: notaConsideracoesFinais.text,
        dataInclusao: DateTime.now().toString().substring(0, 16),
      ),
    );

    return res;
  }

  void openReuniao(Tcc tcc) {
    tccSelected.value = tcc;
    openInfosReuniao.value = true;
  }

  void clear() {
    openInfosReuniao.value = false;
    tccSelected.value = Tcc.empty();
  }

  Future<void> init() async {
    await loadTccs();
  }

  Future<(bool status, String message)> checkIfUserAlreadyGaveANote(String idTcc) async {
    final res = await methods.checkIfUserAlreadyGaveANote(idTcc);
    return res;
  }
}
