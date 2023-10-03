import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/core/components/button_pattern.dart';
import 'package:tcc/core/components/dialog_pattern.dart';
import 'package:tcc/core/components/input_field_pattern.dart';
import 'package:tcc/core/components/page_state.dart';
import 'package:tcc/core/components/snack_bar_messenger.dart';
import 'package:tcc/modules/home/controller/avaliacoes_controller.dart';

import '../../../core/components/text_pattern.dart';
import '../../../core/theme/color_outlet.dart';
import '../controller/home_controller.dart';
import 'components/card_tcc.dart';
import 'components/skeleton_card_tcc.dart';

class Avaliacoes extends StatefulWidget {
  const Avaliacoes({super.key});

  @override
  State<Avaliacoes> createState() => _AvaliacoesState();
}

class _AvaliacoesState extends PageState<Avaliacoes, AvaliacoesController> {
  HomeController homeController = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.init();
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.clear();
    controller.isLoad.value = true;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder(
        valueListenable: controller.tccSelected,
        builder: (context, value, child) => Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextPattern(
                    text: controller.tccSelected.value.nomeAluno == '' ? 'Avaliações de TCCs' : 'Avaliação em andamento',
                    fontSize: 30,
                    color: Colors.black,
                  ).black(),
                  Visibility(
                    visible: controller.tccSelected.value.nomeAluno != '',
                    child: IconButton(
                      onPressed: () {
                        controller.clear();
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
              const SizedBox(height: 30),
              Visibility(
                visible: controller.tccSelected.value.nomeAluno != '',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextPattern(
                          text: 'Informações do TCC',
                          fontSize: 18,
                          color: Colors.black,
                        ).semiBold(),
                        InputFieldPattern(
                          label: 'TCC',
                          hintText: 'Nome do TCC',
                          readOnly: true,
                          controller: TextEditingController(text: controller.tccSelected.value.tema),
                        ),
                        InputFieldPattern(
                          label: 'Aluno',
                          hintText: 'Nome do Aluno',
                          readOnly: true,
                          controller: TextEditingController(text: controller.tccSelected.value.nomeAluno),
                        ),
                        const SizedBox(height: 18),
                        TextPattern(
                          text: 'Introdução',
                          fontSize: 18,
                          color: Colors.black,
                        ).semiBold(),
                        InputFieldPattern(
                          label: 'Nota com base justificativa da escolha, relevância do tema e definição clara do problema.',
                          hintText: 'Digite a nota de 0 a 10',
                          digitsOnly: true,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          suffixIcon: Icons.do_not_disturb_on_outlined,
                          suffixIconFunction: () {
                            controller.notaIntroducao.text = '0';
                          },
                          controller: controller.notaIntroducao,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        TextPattern(
                          text: 'Definição dos Objetivos',
                          fontSize: 18,
                          color: Colors.black,
                        ).semiBold(),
                        InputFieldPattern(
                          label: 'Adequação dos objetivos frente ao problema proposto.',
                          hintText: 'Digite a nota de 0 a 10',
                          digitsOnly: true,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          suffixIcon: Icons.do_not_disturb_on_outlined,
                          suffixIconFunction: () {
                            controller.notaDefinicaoObjetivos.text = '0';
                          },
                          controller: controller.notaDefinicaoObjetivos,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        TextPattern(
                          text: 'Revisão Bibliográfica',
                          fontSize: 18,
                          color: Colors.black,
                        ).semiBold(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: InputFieldPattern(
                                label: 'Redação com clareza, terminologia técnica, conceitos científicos, ortografia e concordância.',
                                hintText: 'Digite a nota de 0 a 10',
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                suffixIcon: Icons.do_not_disturb_on_outlined,
                                suffixIconFunction: () {
                                  controller.notaRevisaoBibliograficaP1.text = '0';
                                },
                                controller: controller.notaRevisaoBibliograficaP1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: InputFieldPattern(
                                label:
                                    'Abordagem sequencial lógica, equilibrada e ordenada. Revisão com abrangência sobre o problema investigativo.',
                                hintText: 'Digite a nota de 0 a 10',
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                suffixIcon: Icons.do_not_disturb_on_outlined,
                                suffixIconFunction: () {
                                  controller.notaRevisaoBibliograficaP2.text = '0';
                                },
                                controller: controller.notaRevisaoBibliograficaP2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        TextPattern(
                          text: 'Orientação Metodológica',
                          fontSize: 18,
                          color: Colors.black,
                        ).semiBold(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: InputFieldPattern(
                                label: 'Procedimentos adequados e bem definidos',
                                hintText: 'Digite a nota de 0 a 10',
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                suffixIcon: Icons.do_not_disturb_on_outlined,
                                suffixIconFunction: () {
                                  controller.notaOrientacaoMetodologicaP1.text = '0';
                                },
                                controller: controller.notaOrientacaoMetodologicaP1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: InputFieldPattern(
                                label: 'Coerência dos objetivos, metodologia e tipo de instrumentos.',
                                hintText: 'Digite a nota de 0 a 10',
                                digitsOnly: true,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                suffixIcon: Icons.do_not_disturb_on_outlined,
                                suffixIconFunction: () {
                                  controller.notaOrientacaoMetodologicaP2.text = '0';
                                },
                                controller: controller.notaOrientacaoMetodologicaP2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        InputFieldPattern(
                          label: 'Comentários*',
                          hintText: 'Digite aqui seus comentários sobre a avaliação',
                          multiline: true,
                          controller: controller.notaConsideracoesFinais,
                        ),
                        const SizedBox(height: 32),
                        ButtonPattern(
                          label: 'Enviar avaliação',
                          onPressed: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            DialogPattern.show(
                              context: context,
                              width: 0.3,
                              child: Material(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextPattern(
                                      text: 'Atenção',
                                      color: Colors.red,
                                      fontSize: 24,
                                    ).bold(),
                                    const SizedBox(height: 32),
                                    TextPattern(
                                      text: 'Deseja realmente enviar a avaliação? Depois de enviada não será possível alterar a avaliação.',
                                      fontSize: 18,
                                    ).regular(),
                                    const SizedBox(height: 48),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.14,
                                          child: ButtonPattern(
                                            label: 'Cancelar',
                                            onPressed: () {
                                              Modular.to.pop();
                                            },
                                            color: Colors.red,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.14,
                                          child: ButtonPattern(
                                            label: 'Confirmar',
                                            onPressed: () async {
                                              await controller.addAvaliacao().then((value) async {
                                                if (value.$1) {
                                                  Modular.to.pop();
                                                  controller.clear();
                                                  snackBarMessenger(context: context, message: value.$2, color: Colors.green);
                                                  await controller.loadTccs();
                                                } else {
                                                  snackBarMessenger(context: context, message: value.$2, color: Colors.red);
                                                }
                                              });
                                            },
                                            color: ColorOutlet.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: controller.tccSelected,
                builder: (context, value, child) => Visibility(
                  visible: controller.tccSelected.value.nomeAluno == '',
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
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CardTcc(
                            tcc: controller.listTccs.value[index],
                            isAvaliacao: homeController.user.value.type == 'Professor',
                            isCordenador: false,
                            onPressedInitAvaliacao: () {
                              controller.checkIfUserAlreadyGaveANote(controller.listTccs.value[index].id.toString()).then((value) {
                                if (value.$1) {
                                  snackBarMessenger(context: context, message: value.$2, color: Colors.red);
                                } else {
                                  controller.openReuniao(controller.listTccs.value[index]);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
