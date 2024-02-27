import 'package:flutter/material.dart';
import 'package:see_later_app/global.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const TextFieldWidget(
      {super.key,
      this.onSaved,
      this.validator,
      required this.hintText,
      required this.prefixIconData,
      this.suffixIconData,
      required this.obscureText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      style: const TextStyle(
        color: Global.mediumBlue,
        fontSize: 14.0,
      ),
      cursorColor: Global.mediumBlue,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Global.mediumBlue),
        ),
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
