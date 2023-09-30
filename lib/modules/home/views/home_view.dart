import 'package:flutter/material.dart';
import 'package:tcc/core/components/page_state.dart';
import 'package:tcc/core/components/text_pattern.dart';
import 'package:tcc/modules/home/views/reunioes.dart';

import '../../../core/theme/color_outlet.dart';
import '../controller/home_controller.dart';
import 'avaliacoes.dart';
import 'configs.dart';
import 'tcc_page.dart';

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
                ValueListenableBuilder(
                  valueListenable: controller.user,
                  builder: (context, value, child) => ValueListenableBuilder(
                    valueListenable: controller.currentPage,
                    builder: (context, value, child) => Column(
                      children: [
                        Visibility(
                          visible: controller.user.value.type == 'Aluno' || controller.user.value.type == 'Coordenador',
                          child: buttonLateral(
                            label: 'Gereciamento de TCC',
                            isSelect: controller.currentPage.value == 0,
                            icon: Icons.description,
                            onPressed: () {
                              controller.currentPage.value = 0;
                              controller.pageController.jumpToPage(0);
                            },
                          ),
                        ),
                        Visibility(
                          visible: controller.user.value.type == 'Aluno',
                          child: buttonLateral(
                            label: 'Reuniões',
                            isSelect: controller.currentPage.value == 1,
                            icon: Icons.groups,
                            onPressed: () {
                              controller.currentPage.value = 1;
                              controller.pageController.jumpToPage(1);
                            },
                          ),
                        ),
                        Visibility(
                          visible: controller.user.value.type == 'Professor',
                          child: buttonLateral(
                            label: 'Avaliações',
                            isSelect: controller.currentPage.value == 2,
                            icon: Icons.thumbs_up_down,
                            onPressed: () {
                              controller.currentPage.value = 2;
                              controller.pageController.jumpToPage(2);
                            },
                          ),
                        ),
                        Visibility(
                          visible: controller.user.value.type == 'Coordenador',
                          child: buttonLateral(
                            label: 'Cronograma',
                            isSelect: controller.currentPage.value == 3,
                            icon: Icons.calendar_month,
                            onPressed: () {
                              controller.currentPage.value = 3;
                              controller.pageController.jumpToPage(3);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller.user,
            builder: (context, value, child) => SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  children: [
                    Visibility(
                      visible: controller.user.value.type == 'Aluno' || controller.user.value.type == 'Coordenador',
                      child: const TccPage(),
                    ),
                    Visibility(
                      visible: controller.user.value.type == 'Aluno',
                      child: const Reunioes(),
                    ),
                    Visibility(
                      visible: controller.user.value.type == 'Professor',
                      child: const Avaliacoes(),
                    ),
                    Visibility(
                      visible: controller.user.value.type == 'Coordenador',
                      child: const Configs(),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
      color: Colors.white.withOpacity(isSelect ? 0.2 : 0),
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
