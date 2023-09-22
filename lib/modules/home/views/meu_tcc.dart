import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/core/components/button_pattern.dart';
import 'package:tcc/core/components/dialog_pattern%20copy.dart';
import 'package:tcc/core/components/input_field_pattern.dart';
import 'package:tcc/core/components/text_pattern.dart';
import 'package:tcc/core/theme/color_outlet.dart';

class MeuTcc extends StatefulWidget {
  const MeuTcc({super.key});

  @override
  State<MeuTcc> createState() => _MeuTccState();
}

class _MeuTccState extends State<MeuTcc> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPattern(
          text: 'TCC',
          fontSize: 30,
          color: Colors.black,
        ).black(),
        // Padding(
        //   padding: const EdgeInsets.only(top: 20, bottom: 20),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       SizedBox(
        //         width: MediaQuery.of(context).size.width * 0.2,
        //         child: ButtonPattern(
        //           label: 'Adicionar TCC',
        //           onPressed: () {},
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Padding(
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
                              label: 'Título do trabalho',
                              hintText: 'Ex: Desenvolvimento de um aplicativo',
                              controller: TextEditingController(),
                            ),
                            InputFieldPattern(
                              label: 'Link do documento',
                              hintText: 'Coloque o link do documento do TCC',
                              controller: TextEditingController(),
                            ),
                            InputFieldPattern(
                              label: 'Cordenador(a)',
                              hintText: 'Clique aqui para selecionar um(a) cordenador(a)',
                              controller: TextEditingController(),
                            ),
                          ],
                        ),
                        ButtonPattern(
                          label: 'Enviar proposta',
                          onPressed: () {},
                        )
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
                              controller: TextEditingController(),
                              onTap: () {},
                            ),
                            InputFieldPattern(
                              label: 'Coorientador(a)*',
                              hintText: 'Clique aqui para selecionar um(a) coorientador(a)',
                              controller: TextEditingController(),
                              onTap: () {
                                DialogPattern.show(
                                  width: 0.4,
                                  context: context,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.5,
                                    child: Column(
                                      children: [
                                        const Column(
                                          children: [],
                                        ),
                                        ButtonPattern(
                                          label: 'Fechar',
                                          onPressed: () {
                                            Modular.to.pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: ButtonPattern(
                                label: 'Selecionar banca avaliadora',
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorOutlet.primaryColor.withOpacity(0.1),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
