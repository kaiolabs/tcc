import 'package:flutter/material.dart';

import '../theme/color_outlet.dart';
import '../theme/size_outlet.dart';

class DialogPattern {
  static Future show({
    /// context to be used to show the dialog
    required BuildContext context,

    /// quando o dialog for fechado, executa essa função
    Function()? onClosed,

    /// content to be displayed inside the dialog
    required Widget child,

    /// Pattern: 0.9 = 90% of screen width
    double width = 0.9,

    /// background color of the dialog (default: Colors.white)

    /// borderRadius of the dialog (default: 8)
    double borderRadius = 8,

    /// padding content of the dialog (default: 10)
    EdgeInsets padding = const EdgeInsets.all(10),

    /// lockBackButton: true = disable back button (default: false)
    bool lockBackButton = false,
  }) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        reverseTransitionDuration: const Duration(milliseconds: 250),
        transitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return _Dialog(
            width: width,
            backgroundColor: Theme.of(context).brightness == Brightness.dark ? ColorOutlet.colorBlackPearlDark : ColorOutlet.colorWhite,
            borderRadius: borderRadius,
            padding: padding,
            lockBackButton: lockBackButton,
            child: child,
          );
        },
      ),
    ).then((value) {
      onClosed?.call();
    });
  }

  static Widget button({
    required String label,
    required IconData icon,
    required Function() onPressed,
  }) {
    return _Button(
      label: label,
      icon: icon,
      onPressed: onPressed,
    );
  }

  static Widget buttonCheckBox({
    required String label,
    required Function() onPressed,
    required ValueNotifier<bool> value,
    bool isRadio = false,
    bool isLineDown = true,
  }) {
    return _ButtonCheck(
      label: label,
      onPressed: onPressed,
      value: value,
      isRadio: isRadio,
      isLineDown: isLineDown,
    );
  }
}

class _Dialog extends StatefulWidget {
  final Widget child;
  final double width;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final bool lockBackButton;

  const _Dialog({
    Key? key,
    required this.child,
    required this.width,
    required this.backgroundColor,
    required this.borderRadius,
    required this.padding,
    required this.lockBackButton,
  }) : super(key: key);

  @override
  State<_Dialog> createState() => __DialogState();
}

class __DialogState extends State<_Dialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.lockBackButton) {
          return false;
        } else {
          Navigator.pop(context);
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.lockBackButton) {
                    return;
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Center(
                child: Container(
                  padding: widget.padding,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                  width: MediaQuery.of(context).size.width * widget.width,
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Button extends StatefulWidget {
  final String label;
  final IconData icon;
  final Function() onPressed;
  const _Button({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_Button> createState() => __ButtonState();
}

class __ButtonState extends State<_Button> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
        child: InkWell(
          borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Theme.of(context).brightness == Brightness.dark ? ColorOutlet.colorBlackPearlDark : ColorOutlet.colorWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 8),
                      Icon(
                        widget.icon,
                        color: ColorOutlet.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.label,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            widget.onPressed.call();
          },
        ),
      ),
    );
  }
}

class _ButtonCheck extends StatefulWidget {
  final String label;
  final Function() onPressed;
  final ValueNotifier<bool> value;
  final bool isRadio;
  final bool isLineDown;
  const _ButtonCheck({
    required this.label,
    required this.onPressed,
    required this.value,
    required this.isRadio,
    required this.isLineDown,
  });

  @override
  State<_ButtonCheck> createState() => _ButtonCheckState();
}

class _ButtonCheckState extends State<_ButtonCheck> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
      child: InkWell(
        borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: widget.value,
                      builder: (context, value, child) => SizedBox(
                        width: 25,
                        height: 25,
                        child: Visibility(
                          visible: widget.isRadio,
                          replacement: Checkbox(
                            value: widget.value.value,
                            onChanged: (value) => widget.onPressed(),
                          ),
                          child: Radio(
                            value: true,
                            groupValue: widget.value.value,
                            onChanged: (value) => widget.onPressed(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.label,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.isLineDown,
                child: const Divider(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          widget.onPressed();
        },
      ),
    );
  }
}
