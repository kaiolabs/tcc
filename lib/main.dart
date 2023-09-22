import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'core/init_app/init_app.dart';
import 'core/services/init/init_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await InitDatabase().initSupaBase();
  await InitApp().initSorage();

  runApp(
    ModularApp(module: AppModule(), child: const AppWidget()),
  );
}
