import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/screens/widgets/wave_widget.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Global.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height - 200,
            color: const Color(0xff7098DA),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3.0,
              color: Global.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset('assets/images/logo-white.svg'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 250.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Feed'),
                InkWell(
                  child: const Text(
                    'Voltar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff7098DA),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
