import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/register_model.dart';
import 'package:see_later_app/screens/home/home.dart';
import 'package:see_later_app/screens/widgets/button_widget.dart';
import 'package:see_later_app/screens/widgets/textfield_widget.dart';
import 'package:see_later_app/screens/widgets/wave_widget.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late RegisterRequestModel requestModel;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;

   @override
  void initState() {
    super.initState();
    requestModel = RegisterRequestModel();
  }

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
            child: Form(
              key: globalFormKey,
              child: Center(
                child: ListView(
                  children: <Widget>[
                    TextFieldWidget(
                      hintText: 'Nome',
                      obscureText: false,
                      prefixIconData: Icons.account_circle_rounded,
                      suffixIconData: Icons.check,
                      onChanged: (value) {},
                      onSaved: (input) => requestModel.name = input,
                      validator: _validarNome,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFieldWidget(
                      hintText: 'E-mail',
                      obscureText: false,
                      prefixIconData: Icons.mail_outline,
                      suffixIconData: Icons.check,
                      onChanged: (value) {},
                      onSaved: (input) => requestModel.email = input
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                     TextFieldWidget(
                      hintText: 'Confirme seu e-mail',
                      obscureText: false,
                      prefixIconData: Icons.mail_outline,
                      suffixIconData: Icons.check,
                      onChanged: (value) {},
                      onSaved: (input) => requestModel.confirm_email = input),
                    const SizedBox(
                      height: 10.0,
                    ),
                   TextFieldWidget(
                        hintText: 'Senha',
                        obscureText: true,
                        prefixIconData: Icons.lock_outline,
                        suffixIconData: Icons.visibility,
                        onSaved:(input) => requestModel.password = input
                      ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    ButtonWidget(
                        title: 'Criar conta',
                        hasBorder: false,
                        onTap: () async {
                          if (validateAndSave()) {
                           try{
                              AlertDialogService().showLoader(context);
                              await APIService().register(requestModel);
                              AlertDialogService().closeLoader(context);
                              Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));

                             }catch(e){
                              AlertDialogService().closeLoader(context);
                              AlertDialogService().showAlertDefault(context, 'Atenção!', e.toString());
                             }
                        }}),
                    const SizedBox(
                      height: 40.0,
                    ),
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
            ),
          ),
        ],
      ),
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
  String? _validarNome(String? value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    
    if (value!.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }
}
