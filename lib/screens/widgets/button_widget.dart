import 'package:flutter/material.dart';
import 'package:see_later_app/global.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final VoidCallback onTap;
  final double? fontSize;

  const ButtonWidget(
      {super.key,
      this.fontSize,
      required this.title,
      required this.hasBorder,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? Global.white : Global.mediumBlue,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder
              ? Border.all(
                  color: Global.mediumBlue,
                  width: 1.0,
                )
              : const Border.fromBorderSide(
                  BorderSide.none,
                ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: SizedBox(
            height: 45.0,
            child: Center(
              child: Text(title,
                  style: TextStyle(
                    color: hasBorder ? Global.mediumBlue : Global.white,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize!=null? fontSize:16.0,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
