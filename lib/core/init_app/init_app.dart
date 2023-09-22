import 'package:hive_flutter/hive_flutter.dart';

class InitApp {
  initSorage() async {
    await Hive.initFlutter();

    Box boxTheme = await Hive.openBox('theme');
    Box box = await Hive.openBox('logged');
    Box boxEmail = await Hive.openBox('email');

    if (boxTheme.get('theme') == null) {
      boxTheme.put('theme', false);
    }

    if (box.get('logged') == null) {
      box.put('logged', false);
    }

    if (boxEmail.get('email') == null) {
      boxEmail.put('email', '');
    }
  }

  theme() async {
    // implemetação do tema
    // Box boxTheme = await Hive.openBox('theme');
    // bool box = boxTheme.get('theme', defaultValue: false);
    // PreferencesTheme.brightness.value = box ? Brightness.dark : Brightness.light;
  }
}
