import 'package:flutter/material.dart';

import '../theme/color_outlet.dart';
import '../theme/font_family_outlet.dart';
import '../theme/size_outlet.dart';

class ButtonPatternOut extends StatelessWidget {
  final String label;
  final Color? color;
  final String? fontFamily;
  final Function()? onPressed;
  const ButtonPatternOut({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = ColorOutlet.primaryColor,
    this.fontFamily = FontFamilyOutlet.defaultFontFamilyMedium,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(SizeOutlet.borderRadiusSizeNormal)),
      ),
      child: InkWell(
        onTap: onPressed ?? () {},
        borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: color!),
            borderRadius: const BorderRadius.all(Radius.circular(SizeOutlet.borderRadiusSizeNormal)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontFamily: FontFamilyOutlet.defaultFontFamilyMedium,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
