import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcc/core/components/text_pattern.dart';

import '../theme/color_outlet.dart';

Future alertDialogPattern(
  context,
  String title,
  String content, {
  bool? exitMode = false,
  bool confirmMode = false,
  bool markdownMode = false,
  Function()? onConfirm,
  String? confirmText,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark ? ColorOutlet.secondaryColor : ColorOutlet.colorWhiteSmoke,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Inter',
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: !markdownMode,
                child: TextPattern(
                  text: content,
                ).medium(),
              ),
            ],
          ),
          actions: [
            Visibility(
              visible: !confirmMode,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: ColorOutlet.primaryColor,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !confirmMode,
              child: TextButton(
                onPressed: () {
                  exitMode! ? SystemNavigator.pop() : null;
                  onConfirm?.call();
                  Navigator.pop(context, true);
                },
                child: Text(
                  confirmText ?? 'Confirmar',
                  style: const TextStyle(
                    color: ColorOutlet.primaryColor,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            Visibility(
              visible: confirmMode,
              child: TextButton(
                onPressed: () {
                  exitMode! ? SystemNavigator.pop() : null;
                  Navigator.pop(context);
                  onConfirm?.call();
                },
                child: Text(
                  confirmText ?? 'Ok',
                  style: const TextStyle(
                    color: ColorOutlet.primaryColor,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
