import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tcc/core/extensions/string_extensions.dart';

import '../../../core/components/alert_dialog_pattern.dart';
import '../../../core/components/snack_bar_messenger.dart';
import '../../../core/services/api/sign/sign.dart';

class SignController extends ChangeNotifier {
  TextEditingController emailControllerLogin = TextEditingController();
  TextEditingController passwordControllerLogin = TextEditingController();
  ValueNotifier<bool> isLoadingLogin = ValueNotifier<bool>(false);

  TextEditingController emailControllerRegister = TextEditingController();
  TextEditingController passwordControllerRegister = TextEditingController();
  TextEditingController confirmPasswordControllerRegister = TextEditingController();
  ValueNotifier<bool> isLoadingRegister = ValueNotifier<bool>(false);
  TextEditingController nameControllerRegister = TextEditingController();
  TextEditingController matriculaControllerRegister = TextEditingController();
  TextEditingController typeControllerRegister = TextEditingController();
  TextEditingController courseControllerRegister = TextEditingController();

  List<String> types = ['Aluno', 'Professor', 'Coordenador'];

  PageController pageController = PageController(initialPage: 0);
  ValueNotifier<int> currentPage = ValueNotifier<int>(0);

  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();

  clearControllersSignUp() {
    emailControllerRegister.text = '';
    passwordControllerRegister.text = '';
    confirmPasswordControllerRegister.text = '';
    isLoadingRegister.value = false;
  }

  clearControllersSignIn() {
    emailControllerLogin.clear();
    passwordControllerLogin.clear();
    isLoadingLogin.value = false;
  }

  String? validateEmail(String value) {
    if (value.isNotEmpty) {
      if (value.isEmail) {
        return null;
      } else {
        return 'Email inválido';
      }
    } else {
      return 'Campo obrigatório';
    }
  }

  String? validatePassword(String value) {
    if (value.isNotEmpty) {
      if (value.length < 6) {
        return 'A senha deve ter no mínimo 6 caracteres';
      } else {
        return null;
      }
    } else {
      return 'Campo obrigatório';
    }
  }

  Future<void> signIn(BuildContext context) async {
    isLoadingLogin.value = true;
    Box box = Hive.box('logged');
    Box boxEmail = Hive.box('email');

    Sign()
        .signIn(
      email: emailControllerLogin.text,
      password: passwordControllerLogin.text,
    )
        .then((value) {
      if (value.$1) {
        snackBarMessenger(context: context, message: value.$2, color: Colors.green);
        Future.delayed(const Duration(seconds: 1), () {
          box.put('logged', true);
          boxEmail.put('email', emailControllerLogin.text);
          Modular.to.pushNamedAndRemoveUntil('/home/', (route) => false);
          isLoadingLogin.value = false;
        });
      } else {
        snackBarMessenger(context: context, message: value.$2, color: Colors.red);
        isLoadingLogin.value = false;
      }
    });
  }

  Future<void> signUp(BuildContext context) async {
    isLoadingRegister.value = true;

    if (passwordControllerRegister.text != confirmPasswordControllerRegister.text) {
      snackBarMessenger(context: context, message: 'As senhas não são iguais', color: Colors.red);
      isLoadingRegister.value = false;
      return;
    }

    await Sign()
        .signUp(
      email: emailControllerRegister.text,
      password: passwordControllerRegister.text,
      name: nameControllerRegister.text,
      registration: matriculaControllerRegister.text,
      type: typeControllerRegister.text,
    )
        .then((value) {
      if (value.$1) {
        snackBarMessenger(context: context, message: value.$2, color: Colors.green);
        Future.delayed(const Duration(seconds: 1), () {
          isLoadingRegister.value = false;
          alertDialogPattern(
            context,
            'Cadastro realizado com sucesso',
            'Verifique seu email para confirmar o cadastro, verifique também sua caixa de spam caso não encontre o email na caixa de entrada',
            confirmMode: true,
            onConfirm: () {
              pageController.jumpToPage(0);
              clearControllersSignUp();
            },
          );
        });
      } else {
        snackBarMessenger(context: context, message: value.$2, color: Colors.red);
        isLoadingRegister.value = false;
      }
    });
  }
}
