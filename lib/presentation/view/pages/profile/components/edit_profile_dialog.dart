import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProffesionDialog extends HookConsumerWidget {
  final ValueNotifier<String> choiceProfession;
  final String choicedProfession;

  const EditProffesionDialog({
    super.key,
    required this.choiceProfession,
    required this.choicedProfession,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final professionList = [
      "会社員・公務員",
      "経営者・役員",
      "自営業・フリーランス",
      "パート・アルバイト",
      "専業主婦・主夫",
      "無職・休職中",
      "学生",
      "医療関係者",
      "士業",
      "その他",
    ];
    final choicingProfession = useState(choiceProfession.value);

    return AlertDialog(
      title: const Text('職業を選択'),
      backgroundColor: BrandColor.white,
      surfaceTintColor: Colors.transparent,
      content: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < professionList.length; i++) ...{
              AppButton.base(
                onPressed: () {
                  choicingProfession.value = professionList[i];
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: choicingProfession.value == professionList[i]
                      ? BrandColor.baseRed
                      : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                text: professionList[i],
                textStyle: TextStyle(
                  color: choicingProfession.value == professionList[i]
                      ? BrandColor.white
                      : BrandColor.black,
                ),
              )
            },
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            choiceProfession.value = choicedProfession;
            Navigator.of(context).pop();
          },
          child: const Text(
            'キャンセル',
            style: TextStyle(color: BrandColor.baseRed),
          ),
        ),
        TextButton(
          onPressed: () {
            choiceProfession.value = choicingProfession.value;
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: BrandColor.baseRed),
          ),
        ),
      ],
    );
  }
}
