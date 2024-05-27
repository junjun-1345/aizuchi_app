import 'package:aizuchi_app/domain/entity/models/color.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class AppTextForm {
  static const double mediumHeight = 80;

  static Widget base(
    TextEditingController controller, {
    double? height,
    double? width,
    int? maxLines,
    int? maxLength,
    int? minLines,
    Color? curosrColor,
    TextInputType textInputType = TextInputType.text,
    InputDecoration? decoration,
    String hintText = '',
    bool? enabled,
    bool autofocus = false,
    bool obscureText = false,
    TextAlign textAlign = TextAlign.start,
    TextStyle? style,
    TextStyle? hintStyle,
    Widget? suffixIcon,
    Alignment alignment = Alignment.center,
    Function(String)? onChanged,
    Function()? onEditingComplete,
    Function(String)? onFieldSubmitted,
    String? Function(String?)? validator,
    Key? key,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        key: key,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        autofocus: autofocus,
        obscureText: obscureText,
        textAlign: textAlign,
        style: style,
        maxLines: maxLines,
        maxLength: maxLength,
        minLines: minLines,
        cursorColor: curosrColor,
        keyboardType: textInputType,
        enabled: enabled,
        decoration: decoration ??
            InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                borderSide: const BorderSide(
                  color: Colors.black12,
                  width: 1.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
              suffixIcon: suffixIcon,
            ),
      ),
    );
  }

  static Widget medium(TextEditingController controller,
      {int? maxLines,
      double? height,
      double? width,
      String hintText = '',
      String validatorhintText = '',
      TextInputType textInputType = TextInputType.text,
      TextAlign textAlign = TextAlign.start,
      bool isDisabled = false,
      bool autofocus = false,
      int? maxLength,
      Function(String)? onChanged,
      Function()? onEditingComplete,
      String? Function(String?)? validator}) {
    return AppTextForm.base(
      controller,
      height: height ?? AppTextForm.mediumHeight,
      width: width,
      maxLines: maxLines,
      maxLength: maxLength,
      textInputType: textInputType,
      textAlign: textAlign,
      hintText: hintText,
      enabled: !isDisabled,
      style: const TextStyle(fontSize: 14),
      autofocus: autofocus,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return validatorhintText;
            }
            return null;
          },
    );
  }

  static Widget email(
    TextEditingController controller, {
    double? height,
    double? width,
    String? hintText,
    TextAlign textAlign = TextAlign.start,
    bool isDisabled = false,
    bool autofocus = false,
    Function(String)? onChanged,
    Function()? onEditingComplete,
  }) {
    return AppTextForm.base(
      controller,
      height: height ?? AppTextForm.mediumHeight,
      width: width,
      textInputType: TextInputType.emailAddress,
      textAlign: textAlign,
      hintText: hintText ?? 'メールアドレスを入力',
      enabled: !isDisabled,
      style: const TextStyle(fontSize: 14),
      autofocus: autofocus,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      validator: (value) {
        if (value == null || !EmailValidator.validate(value)) {
          return '正しい形式でメールアドレスを入力してください';
        }
        return null;
      },
    );
  }

  static Widget password(
    TextEditingController controller, {
    double? height,
    double? width,
    String? hintText,
    bool isDisabled = false,
    bool obscureText = false,
    bool autofocus = false,
    required VoidCallback? onPressed,
    Function(String)? onChanged,
    Function()? onEditingComplete,
    String? Function(String?)? validator,
  }) {
    return AppTextForm.base(
      controller,
      height: height ?? AppTextForm.mediumHeight,
      width: width,
      maxLines: 1,
      textInputType: TextInputType.visiblePassword,
      hintText: hintText ?? 'パスワードを入力',
      enabled: !isDisabled,
      style: const TextStyle(fontSize: 14),
      obscureText: !obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return 'パスワードを入力してください';
            }
            return null;
          },
      suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          color: BrandColor.baseRed,
          onPressed: onPressed),
    );
  }

  static Widget messageField(
    TextEditingController controller, {
    double? height,
    double? width,
    bool isDisabled = false,
    bool obscureText = false,
    bool autofocus = false,
    Function(String)? onFieldSubmitted,
    Function()? onEditingComplete,
  }) {
    return AppTextForm.base(
      controller,
      textInputType: TextInputType.multiline,
      maxLines: 6,
      minLines: 1,
      curosrColor: BrandColor.baseRed,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        hintText: "メッセージを入力",
        hintStyle: const TextStyle(fontSize: 14),
        filled: true,
        //これがないと余白をとりすぎる
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
      ),
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
    );
  }
}
