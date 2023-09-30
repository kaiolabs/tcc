import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/core/components/button_pattern_request.dart';
import 'package:tcc/core/components/page_state.dart';
import 'package:tcc/core/components/snack_bar_messenger.dart';
import 'package:tcc/modules/home/controller/configs_controller.dart';

import '../../../core/components/input_field_pattern.dart';
import '../../../core/components/text_pattern.dart';

class Configs extends StatefulWidget {
  const Configs({super.key});

  @override
  State<Configs> createState() => _ConfigsState();
}

class _ConfigsState extends PageState<Configs, ConfigsController> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.getConfigs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextPattern(
            text: 'Cronograma',
            fontSize: 30,
            color: Colors.black,
          ).black(),
          const SizedBox(height: 48),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextPattern(
                text: 'Data de entrega do TCC',
                fontSize: 20,
                color: Colors.black,
              ).black(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: InputFieldPattern(
                          label: 'Data inicial da entrega',
                          hintText: 'Defina a data inicial da entrega',
                          controller: controller.dataEntregaTccInicioController,
                          readOnly: true,
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: controller.dataEntregaTccInicio,
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2025),
                            );

                            if (date != null) {
                              controller.dataEntregaTccInicioController.text = DateFormat('dd/MM/yyyy').format(date);
                              controller.dataEntregaTccInicio = date;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: InputFieldPattern(
                          label: 'Data final da entrega',
                          hintText: 'Defina a data final da entrega',
                          controller: controller.dataEntregaTccFimController,
                          readOnly: true,
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: controller.dataEntregaTccFim,
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2025),
                            );

                            if (date != null) {
                              controller.dataEntregaTccFimController.text = DateFormat('dd/MM/yyyy').format(date);
                              controller.dataEntregaTccFim = date;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextPattern(
                text: 'Data de avaliação do TCC',
                fontSize: 20,
                color: Colors.black,
              ).black(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: InputFieldPattern(
                      label: 'Data inicial da avaliação',
                      hintText: 'Defina a data inicial da avaliação',
                      controller: controller.dataAvaliacaoTccInicioController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.dataAvaliacaoTccInicio,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (date != null) {
                          controller.dataAvaliacaoTccInicioController.text = DateFormat('dd/MM/yyyy').format(date);
                          controller.dataAvaliacaoTccInicio = date;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: InputFieldPattern(
                      label: 'Data final da avaliação',
                      hintText: 'Defina a data final da avaliação',
                      controller: controller.dataAvaliacaoTccFimController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.dataAvaliacaoTccFim,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (date != null) {
                          controller.dataAvaliacaoTccFimController.text = DateFormat('dd/MM/yyyy').format(date);
                          controller.dataAvaliacaoTccFim = date;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextPattern(
                text: 'Data segunda chamada',
                fontSize: 20,
                color: Colors.black,
              ).black(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: InputFieldPattern(
                      label: 'Data de início da segunda chamada',
                      hintText: 'Defina a data de início da segunda chamada',
                      controller: controller.dataSegundaChamadaInicioController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.dataSegundaChamadaInicio,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (date != null) {
                          controller.dataSegundaChamadaInicioController.text = DateFormat('dd/MM/yyyy').format(date);
                          controller.dataSegundaChamadaInicio = date;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: InputFieldPattern(
                      label: 'Data de fim da segunda chamada',
                      hintText: 'Defina a data de fim da segunda chamada',
                      controller: controller.dataSegundaChamadaFimController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.dataSegundaChamadaFim,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (date != null) {
                          controller.dataSegundaChamadaFimController.text = DateFormat('dd/MM/yyyy').format(date);
                          controller.dataSegundaChamadaFim = date;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextPattern(
                text: 'Data de avaliação da segunda chamada',
                fontSize: 20,
                color: Colors.black,
              ).black(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: InputFieldPattern(
                      label: 'Data inicial da avaliação da segunda chamada',
                      hintText: 'Defina a data inicial da avaliação da segunda chamada',
                      controller: controller.dataAvaliacaoSegundaChamadaInicioController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.dataAvaliacaoSegundaChamadaInicio,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (date != null) {
                          controller.dataAvaliacaoSegundaChamadaInicioController.text = DateFormat('dd/MM/yyyy').format(date);
                          controller.dataAvaliacaoSegundaChamadaInicio = date;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: InputFieldPattern(
                      label: 'Data final da avaliação da segunda chamada',
                      hintText: 'Defina a data final da avaliação da segunda chamada',
                      controller: controller.dataAvaliacaoSegundaChamadaFimController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.dataAvaliacaoSegundaChamadaFim,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (date != null) {
                          controller.dataAvaliacaoSegundaChamadaFimController.text = DateFormat('dd/MM/yyyy').format(date);
                          controller.dataAvaliacaoSegundaChamadaFim = date;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextPattern(
                text: 'Data terceira chamada',
                fontSize: 20,
                color: Colors.black,
              ).black(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: InputFieldPattern(
                      label: 'Data de início da terceira chamada',
                      hintText: 'Defina a data de início da terceira chamada',
                      controller: controller.dataTerceiraChamadaInicioController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.dataTerceiraChamadaInicio,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (date != null) {
                          controller.dataTerceiraChamadaInicioController.text = DateFormat('dd/MM/yyyy').format(date);
                          controller.dataTerceiraChamadaInicio = date;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: InputFieldPattern(
                      label: 'Data de fim da terceira chamada',
                      hintText: 'Defina a data de fim da terceira chamada',
                      controller: controller.dataTerceiraChamadaFimController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.dataTerceiraChamadaFim,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (date != null) {
                          controller.dataTerceiraChamadaFimController.text = DateFormat('dd/MM/yyyy').format(date);
                          controller.dataTerceiraChamadaFim = date;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextPattern(
                text: 'Data de avaliação da terceira chamada',
                fontSize: 20,
                color: Colors.black,
              ).black(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: InputFieldPattern(
                      label: 'Data inicial da avaliação da terceira chamada',
                      hintText: 'Defina a data inicial da avaliação da terceira chamada',
                      controller: controller.dataAvaliacaoTerceiraChamadaInicioController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.dataAvaliacaoTerceiraChamadaInicio,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (date != null) {
                          controller.dataAvaliacaoTerceiraChamadaInicioController.text = DateFormat('dd/MM/yyyy').format(date);
                          controller.dataAvaliacaoTerceiraChamadaInicio = date;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: InputFieldPattern(
                      label: 'Data final da avaliação da terceira chamada',
                      hintText: 'Defina a data final da avaliação da terceira chamada',
                      controller: controller.dataAvaliacaoTerceiraChamadaFimController,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: controller.dataAvaliacaoTerceiraChamadaFim,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (date != null) {
                          controller.dataAvaliacaoTerceiraChamadaFimController.text = DateFormat('dd/MM/yyyy').format(date);
                          controller.dataAvaliacaoTerceiraChamadaFim = date;
                        }
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: ButtonPatternRequest(
                  isLoading: controller.loading,
                  label: 'Salvar configurações',
                  onPressed: () async {
                    controller.loading.value = true;

                    await controller.saveConfigs().then((value) {
                      if (value.$1) {
                        snackBarMessenger(context: context, message: value.$2, color: Colors.green);
                      } else {
                        snackBarMessenger(context: context, message: value.$2, color: Colors.red);
                      }
                    });

                    controller.loading.value = false;
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
