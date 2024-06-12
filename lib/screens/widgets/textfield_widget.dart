import 'package:flutter/material.dart';
import 'package:see_later_app/global.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final String? initialValue;
  final IconData prefixIconData;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final AutovalidateMode? autovalidateMode;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const TextFieldWidget(
      {super.key,
      this.controller,
      this.onSaved,
      this.validator,
      required this.hintText,
      required this.prefixIconData,
      required this.obscureText,
      this.onChanged,
      this.initialValue,
      this.keyboardType,
      this.maxLines,
      this.autovalidateMode,
      this.suffixIcon,
      this.minLines,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      autovalidateMode: autovalidateMode,
      initialValue: initialValue ?? null,
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      minLines: minLines?? 1,
      maxLines: maxLines?? 1,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Global.mediumBlue,
        fontSize: 14.0,
      ),
      cursorColor: Global.mediumBlue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Global.black, width: 0.5),
        ),
        fillColor: Global.white,
        filled: true,
        labelText: hintText,
        prefixIcon: Icon(prefixIconData, size: 18),
        suffixIcon: suffixIcon,
          
      ),
    );
  }
}
