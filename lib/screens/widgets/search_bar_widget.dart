import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:see_later_app/global.dart';

class SearchBar extends StatelessWidget {
  final VoidCallback? prefixOnPressed;
  final VoidCallback? suffixOnPressed;
  final Function(bool?)? onFocusChange;
  final TextEditingController? controller;

  const SearchBar({
    super.key,
    this.controller,
    this.onFocusChange,

    this.prefixOnPressed,
    required this.suffixOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 40,
        child: Focus(
          onFocusChange: onFocusChange,
          child: TextFormField(
            // initialValue: initialValue,
            // onEditingComplete: onEditingComplete,
            controller: controller,
            // onChanged: onChanged,
            // validator: validator,
            // obscureText: obscureText,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Global.offwhite),
              ),
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 20,
                ),
                onPressed: prefixOnPressed,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 20,
                ),
                onPressed: suffixOnPressed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
