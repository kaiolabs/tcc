import 'package:flutter/material.dart';
import 'package:tcc/core/components/dropdown_pattern.dart';
import 'package:tcc/core/components/page_state.dart';
import 'package:tcc/core/components/text_pattern.dart';

import '../../../core/components/button_pattern_request.dart';
import '../../../core/components/input_field_pattern.dart';
import '../../../core/theme/color_outlet.dart';
import '../controller/sign_controller.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends PageState<FormRegister, SignController> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyRegister,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: InputFieldPattern(
                      controller: controller.matriculaControllerRegister,
                      label: 'Matrícula',
                      hintText: 'Seu número de matrícula',
                      colorLabel: ColorOutlet.colorWhite,
                      validator: (value) {
                        if (value!.length < 3) {
                          return 'Nome muito curto';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.matriculaControllerRegister.text = value.toUpperCase();
                        controller.matriculaControllerRegister.selection = TextSelection.fromPosition(
                          TextPosition(offset: controller.matriculaControllerRegister.text.length),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: InputFieldPattern(
                      controller: controller.nameControllerRegister,
                      label: 'Nome',
                      hintText: 'Insira seu nome',
                      colorLabel: ColorOutlet.colorWhite,
                      validator: (value) {
                        if (value!.length < 3) {
                          return 'Nome muito curto';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              InputFieldPattern(
                controller: controller.emailControllerRegister,
                label: 'Email',
                hintText: 'Insira seu e-mail',
                colorLabel: ColorOutlet.colorWhite,
                validator: (value) {
                  return controller.validateEmail(value);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: InputFieldPattern(
                      controller: controller.passwordControllerRegister,
                      label: 'Senha',
                      hintText: 'Insira sua senha',
                      colorLabel: ColorOutlet.colorWhite,
                      passwordMode: true,
                      validator: (value) {
                        return controller.validatePassword(value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: InputFieldPattern(
                      controller: controller.confirmPasswordControllerRegister,
                      label: 'Confirmar Senha',
                      hintText: 'Confirme sua senha',
                      colorLabel: ColorOutlet.colorWhite,
                      passwordMode: true,
                      validator: (value) {
                        return controller.validatePassword(value);
                      },
                    ),
                  ),
                ],
              ),
              DropdownPattern(
                width: 0.9,
                items: controller.types,
                label: 'Tipo de usuário',
                hintText: 'Selecione um tipo',
                selectedValue: controller.typeControllerRegister,
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ButtonPatternRequest(
                  isLoading: controller.isLoadingRegister,
                  label: 'Criar conta',
                  onPressed: () {
                    if (controller.formKeyRegister.currentState!.validate()) {
                      controller.signUp(context);
                    }
                  },
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextPattern(
                    fontSize: 14,
                    text: 'Já tem uma conta?',
                    color: ColorOutlet.colorWhite,
                  ).regular(),
                  TextButton(
                    onPressed: () {
                      controller.pageController.jumpToPage(0);
                    },
                    child: TextPattern(
                      fontSize: 14,
                      text: 'Entrar',
                      color: ColorOutlet.colorWhite,
                    ).bold(),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
