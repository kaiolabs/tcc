import 'package:flutter/material.dart';
import 'package:tcc/core/components/page_state.dart';
import 'package:tcc/core/components/text_pattern.dart';

import '../../../core/components/button_pattern_request.dart';
import '../../../core/components/input_field_pattern.dart';
import '../../../core/theme/color_outlet.dart';
import '../controller/sign_controller.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends PageState<FormLogin, SignController> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyLogin,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InputFieldPattern(
                    controller: controller.emailControllerLogin,
                    label: 'Email',
                    hintText: 'Insira seu email',
                    colorLabel: ColorOutlet.colorWhite,
                    validator: (value) {
                      return controller.validateEmail(value);
                    },
                  ),
                  InputFieldPattern(
                    controller: controller.passwordControllerLogin,
                    label: 'Password',
                    hintText: 'Senha',
                    colorLabel: ColorOutlet.colorWhite,
                    passwordMode: true,
                    validator: (value) {
                      return controller.validatePassword(value);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ButtonPatternRequest(
                      isLoading: controller.isLoadingLogin,
                      label: 'Entrar',
                      onPressed: () {
                        if (controller.formKeyLogin.currentState!.validate()) {
                          controller.signIn(context);
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextPattern(
                        fontSize: 14,
                        text: 'Não tem uma conta?',
                        color: ColorOutlet.colorWhite,
                      ).regular(),
                      TextButton(
                        onPressed: () {
                          controller.pageController.jumpToPage(1);
                        },
                        child: TextPattern(
                          fontSize: 14,
                          text: 'Cadastre-se ',
                          color: ColorOutlet.colorWhite,
                        ).bold(),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
