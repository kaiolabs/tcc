// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tcc/core/components/button_pattern_request.dart';
import 'package:tcc/core/components/dialog_pattern.dart';
import 'package:tcc/core/components/input_field_pattern.dart';
import 'package:tcc/core/components/page_state.dart';
import 'package:tcc/core/components/snack_bar_messenger.dart';
import 'package:tcc/core/theme/color_outlet.dart';
import 'package:tcc/modules/home/controller/reunioes_controller.dart';
import 'package:tcc/modules/home/models/tcc.dart';

import '../../../core/components/button_pattern.dart';
import '../../../core/components/text_pattern.dart';
import '../models/meeting.dart';

class Reunioes extends StatefulWidget {
  const Reunioes({super.key});

  @override
  State<Reunioes> createState() => _ReunioesState();
}

class _ReunioesState extends PageState<Reunioes, ReunioesController> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.loadReunioes();
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.listReunioes.value = [];
      controller.clear();
      controller.isLoadReunioes.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
            valueListenable: controller.openInfosReuniao,
            builder: (context, value, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextPattern(
                  text: 'Reuniões',
                  fontSize: 30,
                  color: Colors.black,
                ).black(),
                Visibility(
                  visible: controller.openInfosReuniao.value,
                  child: IconButton(
                    onPressed: () {
                      controller.openInfosReuniao.value = false;
                      controller.controllerTcc.text = '';
                      controller.controllerData.text = '';
                      controller.descricaoReuniao.text = '';
                      controller.selected.value = Tcc.empty();
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
          ),
          ValueListenableBuilder(
            valueListenable: controller.openInfosReuniao,
            builder: (context, value, child) => Visibility(
              visible: !controller.openInfosReuniao.value,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ButtonPattern(
                            color: ColorOutlet.secondaryColor,
                            label: 'Registrar reunião',
                            onPressed: () {
                              controller.openInfosReuniao.value = true;
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: TextPattern(
                        text: 'Histórico de reuniões',
                        fontSize: 24,
                        color: ColorOutlet.primaryColor,
                      ).extraBold(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller.openInfosReuniao,
            builder: (context, value, child) => Visibility(
              visible: controller.openInfosReuniao.value,
              child: InputFieldPattern(
                hintText: 'Clique para escolher o TCC da respectiva reunião',
                label: 'TCC',
                controller: controller.controllerTcc,
                onTap: () async {
                  await controller.loadTccs();
                  DialogPattern.show(
                    width: 0.4,
                    context: context,
                    child: Material(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, bottom: 10),
                              child: TextPattern(
                                text: 'Selecione o TCC',
                                fontSize: 22,
                                color: ColorOutlet.primaryColor,
                              ).bold(),
                            ),
                            ListView.builder(
                              itemCount: controller.listTccs.value.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  child: InkWell(
                                    onTap: () {
                                      controller.selected.value = controller.listTccs.value[index];
                                      controller.controllerTcc.text = controller.listTccs.value[index].tema;
                                      Modular.to.pop();
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextPattern(
                                            text: controller.listTccs.value[index].tema,
                                            fontSize: 16,
                                          ).bold(),
                                          const SizedBox(height: 10),
                                          TextPattern(
                                            text: 'Orientador: ${controller.listTccs.value[index].nomeOrientador}',
                                            fontSize: 14,
                                          ).regular(),
                                          const SizedBox(height: 4),
                                          TextPattern(
                                            text: 'Coorientador: ${controller.listTccs.value[index].nomeCoorientador}',
                                            fontSize: 14,
                                          ).regular(),
                                          const SizedBox(height: 4),
                                          TextPattern(
                                            text: 'Aluno: ${controller.listTccs.value[index].nomeAluno}',
                                            fontSize: 14,
                                          ).regular(),
                                          const SizedBox(height: 4),
                                          TextPattern(
                                            text: 'Status: ${controller.listTccs.value[index].statusTcc()}',
                                            fontSize: 14,
                                          ).regular(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: ButtonPattern(
                                label: 'Fechar',
                                onPressed: () {
                                  Modular.to.pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 4),
          ValueListenableBuilder(
            valueListenable: controller.selected,
            builder: (context, value, child) => Visibility(
              visible: controller.selected.value.id != 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: InputFieldPattern(
                          label: 'Data da reunião',
                          hintText: 'Defina a data da reunião',
                          controller: controller.controllerData,
                          readOnly: true,
                          onTap: () async {
                            if (controller.selectedReuniao.value.permissoes != 'RO') {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: controller.selectedDate,
                                firstDate: DateTime(2021),
                                lastDate: DateTime(2025),
                              );
                              if (date != null) {
                                controller.controllerData.text = DateFormat('dd/MM/yyyy').format(date);
                                controller.selectedDate = date;
                              }
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Preencha a data da reunião';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: InputFieldPattern(
                          readOnly: true,
                          label: 'Status',
                          controller: TextEditingController(text: controller.selected.value.statusTcc()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: InputFieldPattern(
                          readOnly: true,
                          label: 'Orientador',
                          controller: TextEditingController(text: controller.selected.value.nomeOrientador),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: InputFieldPattern(
                          readOnly: true,
                          label: 'Coorientador',
                          controller: TextEditingController(text: controller.selected.value.nomeCoorientador),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: InputFieldPattern(
                          readOnly: true,
                          label: 'coordenador',
                          controller: TextEditingController(text: controller.selected.value.nomeCordenador),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: InputFieldPattern(
                          readOnly: true,
                          label: 'Aluno',
                          controller: TextEditingController(text: controller.selected.value.nomeAluno),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  InputFieldPattern(
                    label: 'Descrição da reunião',
                    hintText: 'Descreva o que foi tratado na reunião',
                    controller: controller.descricaoReuniao,
                    multiline: true,
                    readOnly: controller.selectedReuniao.value.permissoes == 'RO',
                  ),
                  const SizedBox(height: 48),
                  Visibility(
                    visible: controller.selectedReuniao.value.permissoes != 'RO',
                    replacement: ButtonPatternRequest(
                      isLoading: controller.isCadastrarTcc,
                      label: 'Fechar reunião',
                      onPressed: () async {
                        controller.isCadastrarTcc.value = false;
                        controller.selectedReuniao.value = Meeting.empty();
                        controller.clear();
                      },
                    ),
                    child: ButtonPatternRequest(
                      isLoading: controller.isCadastrarTcc,
                      label: 'Salvar reunião',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          controller.isCadastrarTcc.value = true;
                          await controller.addReuniao().then(
                            (value) {
                              if (value.$1) {
                                snackBarMessenger(context: context, message: value.$2, color: Colors.green);
                                controller.clear();
                              } else {
                                snackBarMessenger(context: context, message: value.$2, color: Colors.red);
                              }
                            },
                          );
                          controller.isCadastrarTcc.value = false;
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller.openInfosReuniao,
            builder: (context, value, child) => Visibility(
              visible: !controller.openInfosReuniao.value,
              child: ValueListenableBuilder(
                valueListenable: controller.listReunioes,
                builder: (context, value, child) => Expanded(
                  child: Visibility(
                    visible: !controller.isLoadReunioes.value,
                    replacement: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: SkeletonItem(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(width: 8),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      height: 250,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 30,
                                                  width: MediaQuery.of(context).size.width / 2,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 15,
                                                  width: MediaQuery.of(context).size.width / 2,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 15,
                                                  width: MediaQuery.of(context).size.width / 2,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          SkeletonLine(
                                            style: SkeletonLineStyle(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width / 2,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 24),
                                        child: SizedBox(
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 30,
                                                width: MediaQuery.of(context).size.width * 0.15,
                                                child: SkeletonLine(
                                                  style: SkeletonLineStyle(
                                                    height: 30,
                                                    width: MediaQuery.of(context).size.width / 2,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 200,
                                                  width: MediaQuery.of(context).size.width / 2,
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: controller.listReunioes.value.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorOutlet.primaryColor.withOpacity(0.8),
                          boxShadow: [
                            BoxShadow(
                              color: ColorOutlet.primaryColor.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 16),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 250,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextPattern(
                                        text: 'TCC: ${controller.listReunioes.value[index].tcc.tema}',
                                        fontSize: 18,
                                        color: Colors.white,
                                      ).bold(),
                                      const SizedBox(height: 12),
                                      TextPattern(
                                        text:
                                            'Data: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.listReunioes.value[index].dataMeet))}',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ).regular(),
                                      const SizedBox(height: 12),
                                      TextPattern(
                                        text: 'Orientador: ${controller.listReunioes.value[index].tcc.nomeOrientador}',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ).regular(),
                                      const SizedBox(height: 12),
                                      TextPattern(
                                        text: 'Coorientador: ${controller.listReunioes.value[index].tcc.nomeCoorientador}',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ).regular(),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  ButtonPattern(
                                    label: 'Visualizar mais detalhes',
                                    color: Colors.white,
                                    textColor: ColorOutlet.primaryColor,
                                    onPressed: () {
                                      controller.openReuniao(controller.listReunioes.value[index]);
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextPattern(
                                      text: 'Resumo da reunião',
                                      fontSize: 18,
                                      color: Colors.white,
                                    ).bold(),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      height: 200,
                                      child: TextPattern(
                                        text: controller.listReunioes.value[index].descricao,
                                        fontSize: 16,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 10,
                                      ).regular(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
