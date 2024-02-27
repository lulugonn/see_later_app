import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/login_model.dart';
import 'package:see_later_app/screens/progress_hud.dart';
import 'package:see_later_app/screens/home/home.dart';
import 'package:see_later_app/screens/register/register.dart';
import 'package:see_later_app/screens/widgets/button_widget.dart';
import 'package:see_later_app/screens/widgets/textfield_widget.dart';
import 'package:see_later_app/screens/widgets/wave_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginRequestModel requestModel;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
    requestModel = LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    Widget uiSetup(BuildContext context) {
      return Scaffold(
        backgroundColor: Global.white,
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height - 100,
              color: const Color(0xff7098DA),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutQuad,
              top: keyboardOpen ? -size.height / 3.7 : 0.0,
              child: WaveWidget(
                size: size,
                yOffset: size.height / 2.5,
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
            Form(
              key: globalFormKey,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 250.0, left: 30.0, right: 30.0, bottom: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFieldWidget(
                        hintText: 'E-mail',
                        obscureText: false,
                        prefixIconData: Icons.mail_outline,
                        suffixIconData: Icons.check,
                        onChanged: (value) {},
                        onSaved: (input) => requestModel.email = input),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextFieldWidget(
                            hintText: 'Senha',
                            obscureText: true,
                            prefixIconData: Icons.lock_outline,
                            suffixIconData: Icons.visibility,
                            onSaved: (input) => requestModel.password = input),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ButtonWidget(
                        title: 'Entrar',
                        hasBorder: false,
                        onTap: () {
                          if (validateAndSave()) {
                            print(requestModel.toJson());
                            setState(() {
                              isApiCallProcess = true;
                            });
                            APIService apiService = APIService();
                            apiService.login(requestModel).then((value) {
                              print('Registro feito com sucesso');

                              if (value != null) {
                                setState(() {
                                  isApiCallProcess = false;
                                });

                                // if (value.token.isNotEmpty) {
                                //   final snackBar = SnackBar(
                                //       content: Text("Login Successful"));
                                //                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: snackBar));

                                // } else {
                                //   final snackBar =
                                //       SnackBar(content: Text(value.error));
                                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: snackBar));
                                // }
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return Home();
                                }));
                              }
                            }).catchError((onError) {
                              print(onError);
                            });
                          }
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(
                        color: Color(0xff7098DA),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: uiSetup(context),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
