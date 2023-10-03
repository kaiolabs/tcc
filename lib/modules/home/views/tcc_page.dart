// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:tcc/core/components/button_pattern.dart';
import 'package:tcc/core/components/button_pattern_request.dart';
import 'package:tcc/core/components/input_field_pattern.dart';
import 'package:tcc/core/components/page_state.dart';
import 'package:tcc/core/components/snack_bar_messenger.dart';
import 'package:tcc/core/components/text_pattern.dart';
import 'package:tcc/core/theme/color_outlet.dart';
import 'package:tcc/modules/home/controller/home_controller.dart';
import 'package:tcc/modules/home/controller/tcc_controller.dart';
import 'package:tcc/modules/home/views/components/skeleton_card_tcc.dart';

import 'components/card_tcc.dart';
import 'components/list_select.dart';

class TccPage extends StatefulWidget {
  const TccPage({super.key});

  @override
  State<TccPage> createState() => _TccPageState();
}

class _TccPageState extends PageState<TccPage, TccController> {
  HomeController homeController = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.loadTccs();
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.clean();
    controller.isLoad.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.cadastrarTcc,
      builder: (context, value, child) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextPattern(
                    text: 'TCC',
                    fontSize: 30,
                    color: Colors.black,
                  ).black(),
                ),
                Visibility(
                  visible: controller.cadastrarTcc.value,
                  child: IconButton(
                    onPressed: () {
                      controller.cadastrarTcc.value = !controller.cadastrarTcc.value;
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 32,
                      color: ColorOutlet.colorCardRed,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Visibility(
              visible: homeController.user.value.type == 'Professor',
              child: ValueListenableBuilder(
                valueListenable: homeController.cronograma,
                builder: (context, value, child) => Visibility(
                  visible: homeController.cronograma.value.mensagemAvaliacaoTccAtual.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorOutlet.colorCardYellow,
                    ),
                    child: TextPattern(
                      text: homeController.cronograma.value.mensagemAvaliacaoTccAtual,
                      color: Colors.white,
                    ).regular(),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: homeController.user.value.type == 'Aluno' && controller.cadastrarTcc.value == false,
              child: ValueListenableBuilder(
                valueListenable: homeController.cronograma,
                builder: (context, value, child) => Visibility(
                  visible: homeController.cronograma.value.mensagemEntregaTccAtual.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorOutlet.colorCardYellow,
                    ),
                    child: TextPattern(
                      text: homeController.cronograma.value.mensagemEntregaTccAtual,
                      color: Colors.white,
                    ).regular(),
                  ),
                ),
              ),
            ),
            Visibility(visible: !controller.cadastrarTcc.value, child: const SizedBox(height: 32)),
            Visibility(
              visible: !controller.cadastrarTcc.value && homeController.user.value.type == 'Aluno',
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: ButtonPattern(
                        color: ColorOutlet.secondaryColor,
                        label: 'Cadastre seu TCC',
                        onPressed: () {
                          controller.nomeAlunoController.text = homeController.user.value.nome;
                          controller.dataController.text = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
                          controller.cadastrarTcc.value = !controller.cadastrarTcc.value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: homeController.user,
              builder: (context, value, child) => Visibility(
                visible: !controller.cadastrarTcc.value,
                child: ValueListenableBuilder(
                  valueListenable: controller.isLoad,
                  builder: (context, value, child) => Visibility(
                    visible: !controller.isLoad.value,
                    replacement: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => const SkeletonCardTcc(),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.listTccs.value.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: CardTcc(
                          tcc: controller.listTccs.value[index],
                          isCordenador: homeController.user.value.type == 'Coordenador',
                          isAvaliacao: homeController.user.value.type == 'Professor',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: controller.cadastrarTcc.value,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: TextPattern(
                        text: 'Proposta de trabalho de conclusão de curso (TCC)',
                        fontSize: 24,
                      ).bold(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextPattern(
                                    text: 'Prencha o formulário abaixo para adicionar um novo TCC.',
                                  ).semiBold(),
                                  InputFieldPattern(
                                    label: 'Nome aluno(a)',
                                    hintText: 'Isso não deve estar vazio',
                                    controller: controller.nomeAlunoController,
                                    readOnly: true,
                                  ),
                                  InputFieldPattern(
                                    label: 'Data de criação do TCC',
                                    hintText: 'Isso não deve estar vazio',
                                    controller: controller.dataController,
                                    readOnly: true,
                                  ),
                                  InputFieldPattern(
                                    label: 'Título do trabalho',
                                    hintText: 'Ex: Desenvolvimento de um aplicativo',
                                    controller: controller.tituloController,
                                  ),
                                  InputFieldPattern(
                                    label: 'Link do documento',
                                    hintText: 'Coloque o link do documento do TCC',
                                    controller: controller.linkController,
                                  ),
                                  InputFieldPattern(
                                    label: 'Coordenador(a)',
                                    hintText: 'Clique aqui para selecionar um(a) cordenador(a)',
                                    controller: controller.cordenadorController,
                                    onTap: () {
                                      controller.loadCordenadores();
                                      listSelect(
                                        context: context,
                                        list: controller.cordenadores,
                                        selected: controller.cordenador,
                                        controller: controller.cordenadorController,
                                        lebelButton: 'Selecionar cordenador(a)',
                                      );
                                    },
                                  ),
                                ],
                              ),
                              ButtonPatternRequest(
                                isLoading: controller.isCadastrarTcc,
                                label: 'Enviar proposta',
                                onPressed: () async {
                                  controller.isCadastrarTcc.value = true;
                                  await controller.cadastrar().then((value) async {
                                    if (value.$1) {
                                      snackBarMessenger(context: context, message: value.$2, color: Colors.green);
                                      controller.cadastrarTcc.value = false;
                                      controller.clean();
                                      await controller.loadTccs();
                                    } else {
                                      snackBarMessenger(context: context, message: value.$2, color: Colors.red);
                                    }

                                    controller.isCadastrarTcc.value = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextPattern(
                                    text: 'Selecão de orientador(a), coorientador(a) e banca avaliadora.',
                                  ).semiBold(),
                                  InputFieldPattern(
                                    label: 'Nome do orientador(a)',
                                    hintText: 'Clique aqui para selecionar um(a) orientador(a)',
                                    controller: controller.orientadorController,
                                    onTap: () {
                                      controller.loadOrientadores();
                                      listSelect(
                                        context: context,
                                        list: controller.orientadores,
                                        selected: controller.orientador,
                                        controller: controller.orientadorController,
                                        lebelButton: 'Selecionar orientador(a)',
                                      );
                                    },
                                  ),
                                  InputFieldPattern(
                                    label: 'Coorientador(a)*',
                                    hintText: 'Clique aqui para selecionar um(a) coorientador(a)',
                                    controller: controller.coorientadorController,
                                    onTap: () async {
                                      await controller.loadCoorientadores();
                                      await listSelect(
                                        context: context,
                                        list: controller.coorientadores,
                                        selected: controller.coorientador,
                                        controller: controller.coorientadorController,
                                        lebelButton: 'Selecionar coorientador(a)',
                                      );
                                    },
                                  ),
                                  Visibility(
                                    visible: homeController.user.value.type == 'Coordenador',
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: ButtonPattern(
                                        label: 'Selecionar banca avaliadora',
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextPattern(
                                        text: 'Banca avaliadora',
                                        fontSize: 18,
                                        color: ColorOutlet.primaryColor,
                                      ).bold(),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.35,
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorOutlet.primaryColor.withOpacity(0.1),
                                    ),
                                    child: const Column(
                                      children: [],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
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
