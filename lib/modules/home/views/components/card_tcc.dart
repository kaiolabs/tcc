// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:tcc/core/components/dialog_pattern.dart';
import 'package:tcc/core/components/input_field_pattern.dart';
import 'package:tcc/core/components/page_state.dart';
import 'package:tcc/core/components/snack_bar_messenger.dart';
import 'package:tcc/modules/home/controller/tcc_controller.dart';
import 'package:tcc/modules/home/models/tcc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/components/button_pattern.dart';
import '../../../../core/components/text_pattern.dart';
import '../../../../core/theme/color_outlet.dart';
import 'list_select.dart';

class CardTcc extends StatefulWidget {
  final Tcc tcc;
  final Function()? onPressedInitAvaliacao;
  final bool isAvaliacao;
  final bool isCordenador;
  const CardTcc({
    super.key,
    required this.tcc,
    this.onPressedInitAvaliacao,
    this.isAvaliacao = false,
    this.isCordenador = false,
  });

  @override
  State<CardTcc> createState() => _CardTccState();
}

class _CardTccState extends PageState<CardTcc, TccController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !(controller.isBancaComplete(widget.tcc) && widget.isCordenador),
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            // bordas superiores arredondadas
            decoration: const BoxDecoration(
              color: ColorOutlet.colorCardRed,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            alignment: Alignment.center,
            child: TextPattern(
              text: 'Você precisa definir a bancas de avaliação para iniciar a avaliação do TCC!',
              color: Colors.white,
              fontSize: 18,
            ).bold(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(18.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: ColorOutlet.primaryColor.withOpacity(0.8),
            boxShadow: [
              BoxShadow(
                color: ColorOutlet.primaryColor.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
            // borderRadius: (controller.isBancaComplete(widget.tcc) && widget.isCordenador)
            //     ? const BorderRadius.all(Radius.circular(10))
            //     : const BorderRadius.only(
            //         bottomLeft: Radius.circular(10),
            //         bottomRight: Radius.circular(10),
            //       ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextPattern(
                              text: 'TCC - ${widget.tcc.tema.isEmpty ? 'Sem tema' : widget.tcc.tema}',
                              fontSize: 18,
                              color: Colors.white,
                            ).bold(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextPattern(
                                text: 'Aluno(a)',
                                color: Colors.white,
                              ).semiBold(),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: TextPattern(
                                  text: widget.tcc.nomeAluno.isEmpty ? 'Sem aluno' : widget.tcc.nomeAluno,
                                  color: Colors.white,
                                ).regular(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextPattern(
                                text: 'Data postagem',
                                color: Colors.white,
                              ).semiBold(),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: TextPattern(
                                  text: widget.tcc.dataCadastro.isNotEmpty
                                      ? DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(widget.tcc.dataCadastro))
                                      : 'Sem data',
                                  color: Colors.white,
                                ).regular(),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: 45,
                              child: ButtonPattern(
                                label: 'Acessar documento',
                                onPressed: () async {
                                  Uri url = Uri.parse(widget.tcc.link);

                                  if (widget.tcc.link.contains('http')) {
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  }
                                },
                                color: Colors.white,
                                textColor: ColorOutlet.primaryColor,
                              ),
                            ),
                            Visibility(
                              visible: widget.isAvaliacao,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  height: 45,
                                  child: ButtonPattern(
                                    label: 'Iniciar avaliação',
                                    onPressed: () {
                                      widget.onPressedInitAvaliacao != null ? widget.onPressedInitAvaliacao!() : null;
                                    },
                                    color: Colors.white,
                                    textColor: ColorOutlet.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextPattern(
                                  text: 'Status',
                                  color: Colors.white,
                                ).semiBold(),
                                const SizedBox(height: 10),
                                TextPattern(
                                  text: widget.tcc.statusTcc(),
                                  color: Colors.white,
                                ).regular(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextPattern(
                                text: 'Orientador(a)',
                                color: Colors.white,
                              ).semiBold(),
                              const SizedBox(height: 10),
                              TextPattern(
                                text: widget.tcc.nomeOrientador.isEmpty ? 'Sem orientador' : widget.tcc.nomeOrientador,
                                color: Colors.white,
                              ).regular(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextPattern(
                                  text: 'Coorientador(a)',
                                  color: Colors.white,
                                ).semiBold(),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: TextPattern(
                                    text: widget.tcc.nomeCoorientador.isEmpty ? 'Sem coorientador' : widget.tcc.nomeCoorientador,
                                    color: Colors.white,
                                  ).regular(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextPattern(
                                text: 'Coordenador(a)',
                                color: Colors.white,
                              ).semiBold(),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: TextPattern(
                                  text: widget.tcc.nomeCordenador.isEmpty ? 'Sem cordenador' : widget.tcc.nomeCordenador,
                                  color: Colors.white,
                                ).regular(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextPattern(
                              text: 'Banca de avaliação',
                              color: Colors.white,
                            ).semiBold(),
                            const SizedBox(height: 10),
                            Visibility(
                              visible: controller.isBancaComplete(widget.tcc),
                              replacement: TextPattern(
                                text: 'Banca não definida',
                                color: Colors.white,
                              ).regular(),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.18,
                                height: MediaQuery.of(context).size.height * 0.15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    TextPattern(
                                      text: 'Banca 1',
                                      color: Colors.white,
                                    ).semiBold(),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      child: TextPattern(
                                        text: widget.tcc.banca1Client.nome,
                                        color: Colors.white,
                                      ).regular(),
                                    ),
                                    const SizedBox(height: 10),
                                    TextPattern(
                                      text: 'Banca 2',
                                      color: Colors.white,
                                    ).semiBold(),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      child: TextPattern(
                                        text: widget.tcc.banca2Client.nome,
                                        color: Colors.white,
                                      ).regular(),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.isCordenador,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.18,
                          height: 50,
                          child: ButtonPattern(
                            color: Colors.white,
                            textColor: ColorOutlet.primaryColor,
                            label: 'Adicionar banca',
                            onPressed: () {
                              controller.banca1.value = widget.tcc.banca1Client;
                              controller.banca2.value = widget.tcc.banca2Client;
                              controller.banca1Controller.text = widget.tcc.banca1Client.nome;
                              controller.banca2Controller.text = widget.tcc.banca2Client.nome;

                              DialogPattern.show(
                                width: 0.3,
                                backgroundColor: ColorOutlet.backgroundColor,
                                context: context,
                                child: Material(
                                  color: ColorOutlet.backgroundColor,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 22),
                                            child: TextPattern(
                                              text: 'Adicionar banca de avaliação',
                                              color: ColorOutlet.primaryColor,
                                              fontSize: 18,
                                            ).extraBold(),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: ButtonPattern(
                                          label: 'Adicionar banca 1',
                                          onPressed: () async {
                                            await controller.loadBanca();
                                            listSelect(
                                              context: context,
                                              list: controller.banca,
                                              selected: controller.banca1,
                                              controller: controller.banca1Controller,
                                              lebelButton: 'Selecionar avaliador(a)',
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: ButtonPattern(
                                          label: 'Adicionar banca 2',
                                          onPressed: () async {
                                            await controller.loadBanca();
                                            listSelect(
                                              context: context,
                                              list: controller.banca,
                                              selected: controller.banca2,
                                              controller: controller.banca2Controller,
                                              lebelButton: 'Selecionar avaliador(a)',
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.3,
                                        child: InputFieldPattern(
                                          controller: controller.banca1Controller,
                                          label: 'Banca 1',
                                          hintText: 'Nome do avaliador 1',
                                          readOnly: true,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.3,
                                        child: InputFieldPattern(
                                          controller: controller.banca2Controller,
                                          label: 'Banca 2',
                                          hintText: 'Nome do avaliador 2',
                                          readOnly: true,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 32),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.14,
                                              child: ButtonPattern(
                                                color: ColorOutlet.colorCardRed,
                                                label: 'Fechar',
                                                onPressed: () {
                                                  Modular.to.pop();
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.14,
                                              child: ButtonPattern(
                                                label: 'Salvar',
                                                onPressed: () async {
                                                  await controller.saveBanca(widget.tcc).then((value) async {
                                                    if (value.$1) {
                                                      snackBarMessenger(context: context, message: value.$2, color: Colors.green);
                                                      controller.listTccs.value = [];
                                                      await controller.loadTccs();
                                                    } else {
                                                      snackBarMessenger(context: context, message: value.$2, color: Colors.red);
                                                    }
                                                  });
                                                  Modular.to.pop();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextPattern(
                      text: 'Notas',
                      color: Colors.white,
                      fontSize: 20,
                    ).bold(),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextPattern(
                              text: 'Notas orientador',
                              color: Colors.white,
                              fontSize: 16,
                            ).semiBold(),
                            const SizedBox(height: 8),
                            TextPattern(
                              text: widget.tcc.notaOrientado.notaFinalString,
                              color: Colors.white,
                              fontSize: 16,
                            ).regular(),
                          ],
                        ),
                        const SizedBox(width: 28),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextPattern(
                              text: 'Notas banca 1',
                              color: Colors.white,
                              fontSize: 16,
                            ).semiBold(),
                            const SizedBox(height: 8),
                            TextPattern(
                              text: widget.tcc.notaBanca1.notaFinalString,
                              color: Colors.white,
                              fontSize: 16,
                            ).regular(),
                          ],
                        ),
                        const SizedBox(width: 28),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextPattern(
                              text: 'Notas banca 2',
                              color: Colors.white,
                              fontSize: 16,
                            ).semiBold(),
                            const SizedBox(height: 8),
                            TextPattern(
                              text: widget.tcc.notaBanca2.notaFinalString,
                              color: Colors.white,
                              fontSize: 16,
                            ).regular(),
                          ],
                        ),
                        Visibility(visible: !widget.tcc.isNotaFinalComplet(), child: const SizedBox(width: 28)),
                        Visibility(
                          visible: !widget.tcc.isNotaFinalComplet(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextPattern(
                                text: 'Nota parcial (não oficial)',
                                color: Colors.white,
                                fontSize: 16,
                              ).semiBold(),
                              const SizedBox(height: 8),
                              TextPattern(
                                text: widget.tcc.notaFinalTccString,
                                color: Colors.white,
                                fontSize: 16,
                              ).regular(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 28),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextPattern(
                              text: 'Nota final (oficial)',
                              color: Colors.white,
                              fontSize: 16,
                            ).semiBold(),
                            const SizedBox(height: 8),
                            TextPattern(
                              text: widget.tcc.isNotaFinalComplet() ? widget.tcc.notaFinalTccString : 'Nota não definida',
                              color: Colors.white,
                              fontSize: 16,
                            ).regular(),
                          ],
                        ),
                        const SizedBox(width: 28),
                        Visibility(
                          visible: widget.tcc.isNotaFinalComplet(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextPattern(
                                text: 'Status nota final',
                                color: Colors.white,
                                fontSize: 16,
                              ).semiBold(),
                              const SizedBox(height: 8),
                              TextPattern(
                                text: widget.tcc.isAprovado ? 'Aprovado' : 'Reprovado',
                                color: Colors.white,
                                fontSize: 16,
                              ).regular(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
