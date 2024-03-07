import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_model.dart';
import 'package:see_later_app/screens/home/home.dart';
import 'package:see_later_app/screens/widgets/textfield_widget.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class CreateContent extends StatefulWidget {
  const CreateContent({super.key});

  @override
  State<CreateContent> createState() => _CreateContentState();

  
}

class _CreateContentState extends State<CreateContent> {
  late ContentModel order;

 @override
  void initState() {
    super.initState();
    order = ContentModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const UserHeader(
          appBarTitle: 'Conteúdo',
          comeback: true,
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "Salvar",
              backgroundColor: Global.mediumBlue,
              tooltip: 'Salvar conteúdo',
              onPressed: () {
                _salvarConteudo();
              },
              child: const Icon(Icons.save, color: Colors.white, size: 28),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFieldWidget(
                      obscureText: false,
                      prefixIconData: Icons.title,
                      hintText: 'Título',
                       onChanged: (value) {
                          setState(() {
                            order.title = value;
                          });
                        },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFieldWidget(
                        obscureText: false,
                        prefixIconData: Icons.filter_alt,
                        hintText: 'Tipo',
                         onChanged: (value) {
                          setState(() {
                            order.type = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFieldWidget(
                        obscureText: false,
                        prefixIconData: Icons.link,
                        hintText: 'Link',
                         onChanged: (value) {
                          setState(() {
                            order.url = value;
                          });
                        },
                      ),
                    ),
                    TextFieldWidget(
                      obscureText: false,
                      prefixIconData: Icons.info,
                      hintText: 'Descricao',
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                       onChanged: (value) {
                          setState(() {
                            order.notes = value;
                          });
                        },
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Tags',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Global.black),
                          ),
                          child:
                              Text("Faculdade", style: TextStyle(fontSize: 14)),
                        ),
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.black,
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Global.white,
                              size: 11,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  void _salvarConteudo() async {
    try {
      AlertDialogService().showLoader(context);
      await APIService().registerContent(order);
      AlertDialogService().closeLoader(context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const Home();
      }));
      AlertDialogService().showAlertDefault(
          context, 'Parabéns!', 'Conteúdo criado com sucesso!');
    } catch (e) {
      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(context, 'Atenção!', e.toString());
    }
  }
}
