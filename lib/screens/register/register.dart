import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/register_model.dart';
import 'package:see_later_app/screens/nav_bar/nav_bar.dart';
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
  late RegisterRequestModel _requestModel;
  late bool _passwordVisible;
  final GlobalKey<FormState> _registerFormKey  = GlobalKey<FormState>();
  final TextEditingController _registerNameKey = TextEditingController();
  final TextEditingController _registerEmailKey = TextEditingController();
  final TextEditingController _registerEmailConfirmKey = TextEditingController();
  final TextEditingController _registerPasswordKey = TextEditingController();

  bool isApiCallProcess = false;

   @override
  void initState() {
    super.initState();
    _requestModel = RegisterRequestModel();
    _passwordVisible = true;
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
            padding: const EdgeInsets.only(top: 100.0),
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
              key: _registerFormKey,
              child: Center(
                child: ListView(
                  children: <Widget>[
                    TextFieldWidget(
                      controller: _registerNameKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      hintText: 'Nome',
                      obscureText: false,
                      prefixIconData: Icons.account_circle_rounded,
                      onChanged: _validateNome,
                      onSaved: (input) => _requestModel.name = input,
                      validator: _validateNome,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFieldWidget(
                      controller: _registerEmailKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      hintText: 'E-mail',
                      obscureText: false,
                      prefixIconData: Icons.mail_outline,
                      onChanged: _validateEmail,
                      onSaved: (input) => _requestModel.email = input,
                      validator: _validateEmail,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                     TextFieldWidget(
                      controller: _registerEmailConfirmKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      hintText: 'Confirme seu e-mail',
                      obscureText: false,
                      prefixIconData: Icons.mail_outline,
                      onChanged: (value) {},
                      onSaved: (input) => _requestModel.confirm_email = input,
                      validator: (value)=> _validateEmailConfirm(_registerEmailKey.text,value,),),
                    const SizedBox(
                      height: 10.0,
                    ),
                   TextFieldWidget(
                        controller: _registerPasswordKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hintText: 'Senha',
                        obscureText: _passwordVisible,
                        prefixIconData: Icons.lock_outline,
                        suffixIcon:  GestureDetector(onTap: ()=> {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          })
                        }, child: _passwordVisible? Icon(Icons.visibility): Icon(Icons.visibility_off),),
                        onSaved:(input) => _requestModel.password = input,
                        validator: _validatePassword,

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
                              await APIService().register(_requestModel);
                              AlertDialogService().closeLoader(context);
                              Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) {
                                    return NavBar();
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
    final form = _registerFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String? _validateNome(String? value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    
    if (value!.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    String patttern = r'^\S+@\S+$';
    RegExp regExp = new RegExp(patttern);
    
    if (value!.length == 0) {
      return "Informe o e-mail";
    } else if (!regExp.hasMatch(value.trim())) {
      return "E-mail inválido";
    }
    return null;
  }

   String? _validateEmailConfirm(String? email, String? emailConfirm ) {
    String patttern = r'^\S+@\S+$';
    RegExp regExp = new RegExp(patttern);

    if (emailConfirm!.length == 0) {
      return "Informe o e-mail";
    } else if (emailConfirm.toLowerCase().trim().compareTo(email!.toLowerCase().trim())!=0) {
      return "Os valores dos campos e-mail e confirmação de e-mail precisam ser iguais";
    }else if (!regExp.hasMatch(emailConfirm.trim())) {
      return "E-mail inválido";
    }
    return null;
  }

   String? _validatePassword(String? value) {
    String patttern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(patttern);
    
    if (value!.length == 0) {
      return "Informe a senha";
    } else if (!regExp.hasMatch(value)) {
      return "A senha precisa ter:\n• Um caractere especial\n• Letra maiúscula\n• Letra minúscula\n• Um número\n• No mínimo oito caracteres";
    }
    return null;
  }

 
}
