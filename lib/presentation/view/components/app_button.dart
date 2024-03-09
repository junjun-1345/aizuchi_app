import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class AppButton {
  static const double mediumHeight = 40;

  static Widget base({
    String text = "",
    double? height,
    double width = double.infinity,
    Key? key,
    required void Function()? onPressed,
    void Function()? onLongPress,
    void Function(bool)? onHover,
    void Function(bool)? onFocusChange,
    ButtonStyle? style,
    TextStyle? textStyle,
    FocusNode? focusNode,
    bool autofocus = false,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: style ??
            ElevatedButton.styleFrom(
              backgroundColor: BrandColor.baseRed,
              shape: const StadiumBorder(),
              elevation: 0,
            ),
        focusNode: focusNode,
        autofocus: autofocus,
        child: Text(
          text,
          style: textStyle ??
              const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  static Widget medium({
    String text = "",
    double height = AppButton.mediumHeight,
    double width = double.infinity,
    Key? key,
    required void Function()? onPressed,
    void Function()? onLongPress,
    void Function(bool)? onHover,
    void Function(bool)? onFocusChange,
    ButtonStyle? style,
    TextStyle? textStyle,
    FocusNode? focusNode,
    bool autofocus = false,
  }) {
    return AppButton.base(
      text: text,
      height: height,
      width: width,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      textStyle: textStyle,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }

  static Widget google({
    String text = "",
    double? height,
    double? width,
    EdgeInsets? padding,
    required Function onPressed,
    double elevation = 0,
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: SignInButton(
        Buttons.google,
        padding: padding ?? const EdgeInsets.fromLTRB(72, 0, 0, 0),
        shape: const StadiumBorder(),
        text: text,
        onPressed: onPressed,
        elevation: elevation,
      ),
    );
  }

  static Widget apple({
    String text = "",
    double? height,
    double? width,
    EdgeInsets? padding,
    required Function onPressed,
    double elevation = 0,
    Color backgroundColor = Colors.black,
    TextStyle? textStyle,
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: SignInButtonBuilder(
        text: text,
        padding: padding ?? const EdgeInsets.fromLTRB(72, 0, 0, 0),
        icon: Icons.apple,
        shape: const StadiumBorder(),
        backgroundColor: Colors.black,
        onPressed: onPressed,
        elevation: elevation,
      ),
    );
  }
}