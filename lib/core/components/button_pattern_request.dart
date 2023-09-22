import 'package:flutter/material.dart';
import 'package:tcc/core/theme/color_outlet.dart';

import '../theme/size_outlet.dart';
import 'button_pattern.dart';

class ButtonPatternRequest extends ButtonPattern {
  final ValueNotifier<bool> isLoading;
  @override
  final Color color;

  const ButtonPatternRequest({
    super.key,
    required this.isLoading,
    required String label,
    required Function() onPressed,
    this.color = ColorOutlet.secondaryColor,
  }) : super(
          label: label,
          onPressed: onPressed,
          color: color,
          textColor: Colors.white,
        );

  @override
  Function() get onPressed {
    return () {
      super.onPressed!();
    };
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (context, value, child) {
        return value
            ? Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
                ),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Material(
                  color: color,
                  borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            : super.build(context);
      },
    );
  }
}
