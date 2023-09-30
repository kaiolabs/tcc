import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/modules/home/controller/avaliacoes_controller.dart';
import 'package:tcc/modules/home/controller/configs_controller.dart';
import 'package:tcc/modules/home/controller/reunioes_controller.dart';
import 'package:tcc/modules/home/controller/tcc_controller.dart';
import 'package:tcc/modules/home/views/home_view.dart';

import 'controller/home_controller.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HomeController()),
        Bind.lazySingleton((i) => AvaliacoesController()),
        Bind.lazySingleton((i) => ConfigsController()),
        Bind.lazySingleton((i) => TccController()),
        Bind.lazySingleton((i) => ReunioesController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const HomeView()),
      ];
}
