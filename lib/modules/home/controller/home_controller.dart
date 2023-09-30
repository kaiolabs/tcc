import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tcc/modules/home/models/cronograma.dart';
import 'package:tcc/modules/home/models/user.dart';

import '../../../core/log/log_pattern.dart';
import '../../../core/services/api/db/db.dart';
import '../../../core/services/api/methods/methods_api.dart';

class HomeController extends ChangeNotifier {
  MethodsApi methods = MethodsApi();
  DB db = DB();
  LogPattern log = LogPattern();

  ValueNotifier<int> currentPage = ValueNotifier<int>(0);
  PageController pageController = PageController(initialPage: 0);
  ValueNotifier<ClientApp> user = ValueNotifier<ClientApp>(ClientApp.empty());
  ValueNotifier<Cronograma> cronograma = ValueNotifier<Cronograma>(Cronograma.empty());

  Future<bool> checkLogin() async {
    SupabaseClient supabase = Supabase.instance.client;
    if (supabase.auth.currentUser == null) {
      Modular.to.navigate('/');
      return false;
    } else {
      return true;
    }
  }

  Future<void> loadClient() async {
    final res = await methods.get(table: db.users, filter: {'email': Supabase.instance.client.auth.currentUser!.email});

    if (res.isNotEmpty) {
      user.value = ClientApp.fromJson(res[0]);
    }
  }

  // load cronograma
  Future<void> loadCronograma() async {
    final res = await methods.get(table: db.cronograma, filter: {'id': 1});

    if (res.isNotEmpty) {
      cronograma.value = Cronograma.fromJson(res[0]);
    }
  }

  Future<void> init() async {
    await checkLogin();
    await loadClient();
    await loadCronograma();
    if (user.value.type == 'Professor') {
      currentPage.value = 2;
      pageController.jumpToPage(2);
    }
  }
}
