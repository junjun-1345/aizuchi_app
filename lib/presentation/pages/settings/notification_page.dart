import 'package:aizuchi_app/application/di/usecase.dart';
import 'package:aizuchi_app/infrastructure/firebase/auth_imp.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/theme/colors.dart';
import 'package:aizuchi_app/presentation/widgets/button_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final _hourState = useState(00);
    final _minuteState = useState(00);
    final _selectTime = useState(DateTime.now());

    final signInButton = RegisterButton(
      onPressed: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('hour', _hourState.value);
        prefs.setInt('minute', _minuteState.value);
        context.go(PagePath.chat);
      },
      text: '登録する',
    );

    TimeOfDay selectTime = TimeOfDay.now();

    //////////////////////
    // レイアウトの構成
    //////////////////////
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            context.go(PagePath.chat);
          },
        ),
        title: Text("通知設定"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: screenWidth * 0.8,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: selectTime,
                        initialEntryMode:
                            TimePickerEntryMode.inputOnly // 最初に表示する時刻を設定
                        );

                    if (picked != null) {
                      _selectTime.value = DateTime.parse(picked.toString());
                    }
                  },
                  child: Text("時間を選択")),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("通知時間"),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "${_selectTime.value.hour}:${_selectTime.value.minute}",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
              signInButton,
            ],
          ),
        ),
      ),
    );
  }
}
