import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/screens/login/login.dart';
import 'package:see_later_app/screens/register/register.dart';
import 'package:see_later_app/screens/widgets/button_widget.dart';
import 'package:see_later_app/screens/widgets/wave_widget.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

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
            color: Global.offwhite,
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
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset('assets/images/logo.svg'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 350.0, left: 50.0, right: 50.0, bottom: 50.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Salve agora, veja depois:',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Organize\nConteúdos',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ButtonWidget(
                      title: 'Login',
                      hasBorder: false,
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const Login();
                        }));
                      }),
                  // InkWell(onTap: () {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => const Login()));
                  // }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Não tem conta? ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff909090),
                        ),
                      ),
                      InkWell(
                        child: const Text(
                          'Cadastre-se',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff7098DA),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const Register();
                          }));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
