import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:aizuchi_app/presentation/view/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditSexDialog extends HookConsumerWidget {
  final ValueNotifier<SexEnum> choiceSex;
  final SexEnum choicedSex;

  const EditSexDialog({
    super.key,
    required this.choiceSex,
    required this.choicedSex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choicingSex = useState(choicedSex);

    return AlertDialog(
      title: const Text('職業を選択'),
      content: SizedBox(
        child: SizedBox(
          height: 144,
          child: Column(
            children: [
              for (int i = 1; i < 4; i++) ...{
                AppButton.base(
                  onPressed: () {
                    choicingSex.value = SexEnum.values[i];
                    print(choiceSex.value);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: choicingSex.value == SexEnum.values[i]
                        ? BrandColor.baseRed
                        : Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  text: SexEnum.values[i].sexValue ?? "",
                  textStyle: TextStyle(
                    color: choicingSex.value == SexEnum.values[i]
                        ? BrandColor.white
                        : BrandColor.black,
                  ),
                ),
              },
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            choiceSex.value = choicedSex;
            Navigator.of(context).pop();
          },
          child: const Text(
            'キャンセル',
            style: TextStyle(color: BrandColor.baseRed),
          ),
        ),
        TextButton(
          onPressed: () {
            choiceSex.value = choicingSex.value;
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
