import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../core/components/button_pattern.dart';
import '../../../../core/components/dialog_pattern copy.dart';
import '../../../../core/components/text_pattern.dart';
import '../../../../core/theme/color_outlet.dart';
import '../../models/user.dart';

listSelect({
  required BuildContext context,
  required ValueNotifier<List<ClientApp>> list,
  required ValueNotifier<ClientApp> selected,
  required TextEditingController controller,
  required String lebelButton,
}) {
  return DialogPattern.show(
    width: 0.4,
    context: context,
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ValueListenableBuilder(
                valueListenable: selected,
                builder: (context, value, child) => ValueListenableBuilder(
                  valueListenable: list,
                  builder: (context, value, child) => Visibility(
                    visible: list.value.isEmpty,
                    replacement: ListView.builder(
                      itemCount: list.value.length,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: selected.value.email == list.value[index].email ? ColorOutlet.primaryColor.withOpacity(0.3) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              selected.value = list.value[index];
                              controller.text = list.value[index].nome;
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: ColorOutlet.primaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Icon(Icons.person_2),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextPattern(
                                          text: list.value[index].nome,
                                          fontSize: 14,
                                        ).bold(),
                                        const SizedBox(width: 8),
                                        TextPattern(
                                          text: '${list.value[index].type}(a)',
                                          fontSize: 10,
                                          color: ColorOutlet.primaryColor,
                                        ).bold(),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    TextPattern(
                                      text: list.value[index].email,
                                      fontSize: 12,
                                    ).medium(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: SkeletonItem(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SkeletonAvatar(
                                      style: SkeletonAvatarStyle(shape: BoxShape.circle, width: 50, height: 50),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: SkeletonParagraph(
                                        style: SkeletonParagraphStyle(
                                          lines: 3,
                                          spacing: 6,
                                          lineStyle: SkeletonLineStyle(
                                            randomLength: true,
                                            height: 10,
                                            borderRadius: BorderRadius.circular(8),
                                            minLength: MediaQuery.of(context).size.width / 6,
                                            maxLength: MediaQuery.of(context).size.width / 3,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Column(
            children: [],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ButtonPattern(
              label: lebelButton,
              onPressed: () {
                Modular.to.pop();
              },
            ),
          ),
        ],
      ),
    ),
  );
}
