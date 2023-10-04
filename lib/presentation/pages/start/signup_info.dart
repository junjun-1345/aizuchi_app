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

class SignUpInfoPage extends HookConsumerWidget {
  const SignUpInfoPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    final _choiceIndex = useState(0);
    final _birthdayState = useState(DateTime(2000));
    final _nameController = useTextEditingController();

    final signInButton = RegisterButton(
      onPressed: () {
        final usecase = ref.read(accountUsecaseProvider);
        usecase.createAccount(
          _nameController.text,
          _choiceIndex.value,
          _birthdayState.value.toString(),
        );
        context.go(PagePath.chat);
      },
      text: '登録する',
    );

    final birthDayField = OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 56),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: const BorderSide(color: Colors.black12),
      ),
      child: Text(
        "${_birthdayState.value.year}/${_birthdayState.value.month}/${_birthdayState.value.day}",
        style: const TextStyle(
          fontSize: 32,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2200),
        );
        _birthdayState.value = selectedDate!;
      },
    );

    final nullButton = SizedBox(
      child: ChoiceChip(
        label: Text("無回答"),
        selected: _choiceIndex.value == 0,
        backgroundColor: Colors.grey[600],
        selectedColor: Colors.white,
        onSelected: (_) {
          _choiceIndex.value = 0;
        },
      ),
    );

    final menButton = ChoiceChip(
      label: Text("男性"),
      selected: _choiceIndex.value == 1,
      backgroundColor: Colors.grey[600],
      selectedColor: BrandColor.baseBlue,
      onSelected: (_) {
        _choiceIndex.value = 1;
      },
    );

    final womenButton = ChoiceChip(
      label: Text("女性"),
      selected: _choiceIndex.value == 2,
      backgroundColor: Colors.grey[600],
      selectedColor: BrandColor.baseRed,
      onSelected: (_) {
        _choiceIndex.value = 2;
      },
    );

    Widget nameTextform(String hintText) {
      return TextFormField(
        controller: _nameController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.black54,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || !EmailValidator.validate(value)) {
            return 'Please enter some text';
          }
          return null;
        },
      );
    }

    //////////////////////
    // レイアウトの構成
    //////////////////////
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            final service = AuthService();
            service.signOut();
            context.go(PagePath.start);
          },
        ),
        title: Text("新規登録"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: screenWidth * 0.8,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              nameTextform("ユーザーネームを入力"),
              birthDayField,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      nullButton,
                      menButton,
                      womenButton,
                    ],
                  ),
                ],
              ),
              signInButton,
            ],
          ),
        ),
      ),
    );
  }
}
