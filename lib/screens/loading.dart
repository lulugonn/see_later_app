import 'package:flutter/material.dart';
import 'package:see_later_app/global.dart';

class Loading extends StatelessWidget {

  final double opacity;
  final Color color;
  final Animation<Color>? valueColor;

  Loading({
    Key? key,
    this.opacity = 0.1,
    this.color = Colors.grey,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:CircularProgressIndicator(strokeWidth: 3,valueColor: AlwaysStoppedAnimation<Color>(Global.mediumBlue),)
    );

  
  }
}