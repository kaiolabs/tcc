import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tcc/modules/home/models/tcc.dart';
import 'package:tcc/modules/home/models/user.dart';

import '../../../core/log/log_pattern.dart';
import '../../../core/services/api/db/db.dart';
import '../../../core/services/api/methods/methods_api.dart';
import '../models/nota.dart';
import 'home_controller.dart';

class TccController extends ChangeNotifier {
  MethodsApi methods = MethodsApi();
  DB db = DB();
  LogPattern log = LogPattern();

  ValueNotifier<List<ClientApp>> orientadores = ValueNotifier<List<ClientApp>>([]);
  ValueNotifier<List<ClientApp>> cordenadores = ValueNotifier<List<ClientApp>>([]);
  ValueNotifier<List<ClientApp>> coorientadores = ValueNotifier<List<ClientApp>>([]);

  ValueNotifier<List<ClientApp>> bancaSelected = ValueNotifier<List<ClientApp>>([]);
  ValueNotifier<ClientApp> orientador = ValueNotifier<ClientApp>(ClientApp.empty());
  ValueNotifier<ClientApp> cordenador = ValueNotifier<ClientApp>(ClientApp.empty());
  ValueNotifier<ClientApp> coorientador = ValueNotifier<ClientApp>(ClientApp.empty());

  TextEditingController linkController = TextEditingController();
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController cordenadorController = TextEditingController();
  TextEditingController orientadorController = TextEditingController();
  TextEditingController coorientadorController = TextEditingController();

  TextEditingController dataController = TextEditingController();
  TextEditingController nomeAlunoController = TextEditingController();

  ValueNotifier<bool> cadastrarTcc = ValueNotifier<bool>(false);
  ValueNotifier<bool> isCadastrarTcc = ValueNotifier<bool>(false);
  ValueNotifier<bool> isLoad = ValueNotifier<bool>(true);

  TextEditingController banca1Controller = TextEditingController();
  TextEditingController banca2Controller = TextEditingController();
  ValueNotifier<List<ClientApp>> banca = ValueNotifier<List<ClientApp>>([]);
  ValueNotifier<ClientApp> banca1 = ValueNotifier<ClientApp>(ClientApp.empty());
  ValueNotifier<ClientApp> banca2 = ValueNotifier<ClientApp>(ClientApp.empty());

  ValueNotifier<List<Tcc>> listTccs = ValueNotifier<List<Tcc>>([]);

  Future<void> loadTccs() async {
    HomeController homeController = Modular.get<HomeController>();
    List res = [];

    if (homeController.user.value.type == 'Aluno') {
      res = await methods.getTccs(Supabase.instance.client.auth.currentUser!.email!);
    } else if (homeController.user.value.type == 'Coordenador') {
      res = await methods.getTccsCordenador(Supabase.instance.client.auth.currentUser!.email!);
    }

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

  Future<void> loadBanca() async {
    final res = await methods.getBanca();

    if (res.isNotEmpty) {
      banca.value = [];
      banca.value = res.map((e) => ClientApp.fromJson(e)).toList();
    }
  }

  Future<void> loadOrientadores() async {
    final res = await methods.get(table: db.users, filter: {'type': 'Professor'});

    if (res.isNotEmpty) {
      orientadores.value = [];
      orientadores.value = res.map((e) => ClientApp.fromJson(e)).toList();
    }
  }

  Future<void> loadCordenadores() async {
    final res = await methods.get(table: db.users, filter: {'type': 'Coordenador'});

    if (res.isNotEmpty) {
      cordenadores.value = [];
      cordenadores.value = res.map((e) => ClientApp.fromJson(e)).toList();
    }
  }

  Future<void> loadCoorientadores() async {
    final res = await methods.get(table: db.users, filter: {'type': 'Professor'});

    if (res.isNotEmpty) {
      coorientadores.value = [];
      coorientadores.value = res.map((e) => ClientApp.fromJson(e)).toList();
    }
  }

  Future<(bool, String)> cadastrar() async {
    try {
      final res = await methods.post(
        table: db.tcc,
        body: {
          'aluno': Modular.get<HomeController>().user.value.email,
          'nome_aluno': Modular.get<HomeController>().user.value.nome,
          'data_cadastro': DateTime.now().toString().substring(0, 16),
          'tema': tituloController.text,
          'link': linkController.text,
          'cordenador': cordenador.value.email,
          'nome_cordenador': cordenador.value.nome,
          'orientador': orientador.value.email,
          'nome_orientador': orientador.value.nome,
          'coorientador': coorientador.value.email,
          'nome_coorientador': coorientador.value.nome,
          'status': 'A',
          'id_avaliadores': '${cordenador.value.email} |',
        },
      );

      if (res.$1) {
        return (true, 'Sucesso, TCC cadastrado com sucesso!');
      } else {
        return (false, res.$2);
      }
    } on PostgrestException catch (e) {
      log.wtf('Error no post da tabela ${db.tcc}: $e');
      return (false, e.message);
    }
  }

  Future<(bool, String)> saveBanca(Tcc tcc) async {
    try {
      final res = await methods.put(
        table: db.tcc,
        body: {
          'id_avaliadores': '${tcc.orientador} | ${banca1.value.email} | ${banca2.value.email}',
          'banca1': banca1.value.email,
          'banca2': banca2.value.email,
          'status': 'B',
        },
        filter: {'id': tcc.id},
      );

      if (res.$1) {
        return (true, 'Sucesso, Banca cadastrada com sucesso!');
      } else {
        return (false, res.$2);
      }
    } on PostgrestException catch (e) {
      log.wtf('Error no put da tabela ${db.tcc}: $e');
      return (false, e.message);
    }
  }

  void clean() {
    linkController.text = '';
    tituloController.text = '';
    descricaoController.text = '';
    cordenadorController.text = '';
    orientadorController.text = '';
    coorientadorController.text = '';
    dataController.text = '';
    nomeAlunoController.text = '';
    bancaSelected.value = [];
    orientador.value = ClientApp.empty();
    cordenador.value = ClientApp.empty();
    coorientador.value = ClientApp.empty();
  }

  // veririfa se a banca esta completa
  bool isBancaComplete(Tcc tcc) {
    if (tcc.banca1.isEmpty) {
      return false;
    } else if (tcc.banca2.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
