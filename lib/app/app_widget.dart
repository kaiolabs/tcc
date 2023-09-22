import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/theme/preferences_theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: PreferencesTheme.brightness,
      builder: (context, theme, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Unisc Tcc',
          theme: PreferencesTheme.brightness.value == Brightness.light ? ThemeData.light() : ThemeData.dark(),
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
        );
      },
    );
  }
}
