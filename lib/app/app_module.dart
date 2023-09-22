import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/splash_view.dart';

import '../modules/home/home_module.dart';
import '../modules/sign/login_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const SplashView()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/sign', module: LoginModule()),
      ];
}
