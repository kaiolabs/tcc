import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import '../core/theme/color_outlet.dart';
import '../core/theme/font_family_outlet.dart';
import '../core/theme/preferences_theme.dart';
import '../core/theme/size_outlet.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  init() async {
    Box box = Hive.box('logged');

    Future.delayed(
      const Duration(microseconds: 500),
      () {
        if (box.get('logged') == true) {
          Modular.to.pushReplacementNamed('/home/');
        } else {
          Modular.to.pushReplacementNamed('/sign/');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreferencesTheme.brightness.value == Brightness.light ? ColorOutlet.colorWhite : ColorOutlet.secondaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                builder: (context, double value, child) {
                  return AnimatedOpacity(
                    opacity: value,
                    onEnd: () {},
                    duration: const Duration(milliseconds: 600),
                    child: Transform.scale(scale: value, child: child),
                  );
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              top: MediaQuery.of(context).size.height * 0.8,
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                builder: (context, double value, child) {
                  return AnimatedOpacity(
                    opacity: value,
                    duration: const Duration(milliseconds: 600),
                    child: Transform.scale(scale: value, child: child),
                  );
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Image.asset(
                        'assets/images/infinidade.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Text(
                      'Infinity Studios ∞',
                      style: TextStyle(
                        fontFamily: FontFamilyOutlet.defaultFontFamilyMedium,
                        fontSize: SizeOutlet.textSizeMicro1,
                        color: ColorOutlet.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
