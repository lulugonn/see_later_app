import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/models/content_model.dart';
import 'package:see_later_app/screens/home/home.dart';
import 'package:see_later_app/screens/widgets/button_widget.dart';
import 'package:see_later_app/screens/widgets/textfield_widget.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class ContentForm extends StatefulWidget {
  const ContentForm({super.key});

  @override
  State<ContentForm> createState() => _ContentFormState();
}

class _ContentFormState extends State<ContentForm> {

  late ContentModel order;

   @override
  void initState() {
    super.initState();
    order = ContentModel();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Criar conteúdo',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: TextFieldWidget(
                        hintText: 'Título do conteúdo',
                        obscureText: false,
                        prefixIconData: Icons.title,
                        onChanged: (value) {
                          setState(() {
                            order.title = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFieldWidget(
                        hintText: 'URL',
                        obscureText: false,
                        prefixIconData: Icons.link,
                        onChanged: (value) {
                          setState(() {
                            order.url = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFieldWidget(
                        hintText: 'Descrição',
                        obscureText: false,
                        prefixIconData: Icons.description,
                        onChanged: (value) {
                          setState(() {
                            order.notes = value;
                          });
                        },
                      ),
                    ),
                    ButtonWidget(
                        title: 'Salvar',
                        hasBorder: false,
                        onTap: () {
                          _salvarConteudo();
                        }),
                  ],
                ),
              );
          
  }

   void _salvarConteudo() async {
    try {
      AlertDialogService().showLoader(context);
      await APIService().registerContent(order);
      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(context, 'Atenção!','Conteúdo criado com sucesso!');
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //   return const Home();
      // }));
    } catch (e) {
      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(context, 'Atenção!', e.toString());
    }
  }
}

