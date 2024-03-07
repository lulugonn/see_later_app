import 'package:flutter/material.dart';
import 'package:see_later_app/global.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final String? initialValue;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;

  const TextFieldWidget(
      {super.key,
      this.onSaved,
      this.validator,
      required this.hintText,
      required this.prefixIconData,
      this.suffixIconData,
      required this.obscureText,
      this.onChanged,
      this.initialValue,
      this.keyboardType,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue ?? null,
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      maxLines: maxLines?? 1 ,
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
        suffixIcon: GestureDetector(
          onTap: () {},
          child: Icon(
            suffixIconData,
            size: 18,
            color: Global.mediumBlue,
          ),
        ),
      ),
    );
  }
}
