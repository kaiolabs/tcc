import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/modules/sign/view/sign_view.dart';

import 'controller/sign_controller.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => SignController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => SignView(controller: Modular.get<SignController>())),
      ];
}
