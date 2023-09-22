// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tcc/core/theme/color_outlet.dart';

import '../../../core/theme/size_outlet.dart';
import '../controller/sign_controller.dart';
import 'form_login.dart';
import 'form_register.dart';

class SignView extends StatefulWidget {
  final SignController controller;
  const SignView({super.key, required this.controller});

  @override
  State<SignView> createState() => SignViewState();
}

class SignViewState extends State<SignView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorOutlet.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: ColorOutlet.primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/logo_unisc.png',
                          width: 300,
                        ),
                        Image.asset(
                          'assets/images/tcc.png',
                          width: 150,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
                        ),
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: PageView(
                                  onPageChanged: (value) {
                                    widget.controller.currentPage.value = value;
                                  },
                                  controller: widget.controller.pageController,
                                  children: const [
                                    FormLogin(),
                                    FormRegister(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/bock.png',
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ],
        )),
      ),
    );
  }
}
