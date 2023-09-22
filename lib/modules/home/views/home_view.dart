import 'package:flutter/material.dart';
import 'package:tcc/core/components/page_state.dart';
import 'package:tcc/core/components/text_pattern.dart';
import 'package:tcc/modules/home/views/reunioes.dart';

import '../../../core/theme/color_outlet.dart';
import '../controller/home_controller.dart';
import 'avaliacoes.dart';
import 'configs.dart';
import 'meu_tcc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends PageState<HomeView, HomeController> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorOutlet.backgroundColor,
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.2,
            color: ColorOutlet.primaryColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/logo_unisc.png',
                            width: 130,
                          ),
                          Image.asset(
                            'assets/images/tcc.png',
                            width: 70,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    buttonLateral(
                      label: 'Meu TCC',
                      isSelect: controller.currentPage.value == 0,
                      icon: Icons.description,
                      onPressed: () {
                        controller.currentPage.value = 0;
                        controller.pageController.jumpToPage(0);
                      },
                    ),
                    buttonLateral(
                      label: 'Reuniões',
                      isSelect: controller.currentPage.value == 1,
                      icon: Icons.groups,
                      onPressed: () {
                        controller.currentPage.value = 1;
                        controller.pageController.jumpToPage(1);
                      },
                    ),
                    buttonLateral(
                      label: 'Avaliações',
                      isSelect: controller.currentPage.value == 2,
                      icon: Icons.thumbs_up_down,
                      onPressed: () {
                        controller.currentPage.value = 2;
                        controller.pageController.jumpToPage(2);
                      },
                    ),
                    buttonLateral(
                      label: 'Configurações',
                      isSelect: controller.currentPage.value == 2,
                      icon: Icons.settings,
                      onPressed: () {
                        controller.currentPage.value = 3;
                        controller.pageController.jumpToPage(3);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                children: const [
                  MeuTcc(),
                  Reunioes(),
                  Avaliacoes(),
                  Configs(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget buttonLateral({
  required String label,
  required Function() onPressed,
  required bool isSelect,
  required IconData icon,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onPressed.call();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: ColorOutlet.colorWhite,
                ),
                const SizedBox(width: 10),
                TextPattern(
                  text: label,
                  color: ColorOutlet.colorWhite,
                ).semiBold()
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
