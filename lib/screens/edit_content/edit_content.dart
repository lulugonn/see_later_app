import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_request_model.dart';
import 'package:see_later_app/models/content_response_model.dart';
import 'package:see_later_app/screens/home/home.dart';
import 'package:see_later_app/screens/nav_bar/nav_bar.dart';
import 'package:see_later_app/screens/widgets/textfield_widget.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class EditContent extends StatefulWidget {
  const EditContent({super.key, required this.content});
  final ContentResponseModel content;

  @override
  State<EditContent> createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  UserHeader(
                      appBarTitle: 'Conteúdo',
                      comeback: true,
                      showUser: true,
                    ),
        backgroundColor: Global.white,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "Salvar",
              backgroundColor: Global.mediumBlue,
              tooltip: 'Salvar conteúdo',
              onPressed: () {
                _updateContent();
              },
              child: const Icon(Icons.save, color: Colors.white, size: 28),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              heroTag: "Excluir",
              backgroundColor: Colors.red,
              tooltip: 'Excluir conteúdo',
              onPressed: () {
                 Future.delayed(Duration.zero,
                            () => _deleteContent(widget.content.id!));
              },
              child: const Icon(Icons.delete, color: Colors.white, size: 28),
            ),
          ],
        ),
        body: 
                   SingleChildScrollView(
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
                                  initialValue: widget.content.title,
                                  obscureText: false,
                                  prefixIconData: Icons.title,
                                  hintText: 'Título',
                                  onChanged: (value) {
                          setState(() {
                            widget.content.title = value;
                          });}
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: TextFieldWidget(
                                    initialValue: widget.content.type,
                                    obscureText: false,
                                    prefixIconData: Icons.filter_alt,
                                    hintText: 'Tipo',
                                     onChanged: (value) {
                          setState(() {
                            widget.content.type = value;
                          });
                        },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: TextFieldWidget(
                                    initialValue: widget.content.url,
                                    obscureText: false,
                                    prefixIconData: Icons.link,
                                    hintText: 'Link',
                                    onChanged: (value) {
                          setState(() {
                            widget.content.url = value;
                          });}
                                  ),
                                ),
                                TextFieldWidget(
                                  initialValue:  widget.content.notes,
                                  obscureText: false,
                                  prefixIconData: Icons.info,
                                  hintText: 'Descricao',
                                  onChanged: (value) {
                          setState(() {
                            widget.content.notes = value;
                          });}
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
                                        border: Border.all(
                                            width: 1, color: Global.black),
                                      ),
                                      child: Text("Faculdade",
                                          style: TextStyle(fontSize: 14)),
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
                          Container(
                            margin: EdgeInsets.only(top: 60),
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 63.0),
                            decoration: BoxDecoration(
                            color: Global.darkGreen,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 1, color: Global.darkGreen),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.check, color: Global.white),
                                ),
                                Text("Marcar como concluído",
                                    style: TextStyle(fontSize: 16, color: Global.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )));
  }

  void _updateContent() async {
    try {
      AlertDialogService().showLoader(context);
      await APIService().updateContent(widget.content);
      AlertDialogService().closeLoader(context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const NavBar();
      }));
      AlertDialogService().showAlertDefault(
          context, 'Parabéns!', 'Conteúdo atualizado com sucesso!');
    } catch (e) {
      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(context, 'Atenção!', e.toString());
    }
  }

  void showAlertConfirm(BuildContext context, title, content, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text(title ?? 'Atenção!'),
          content: Text(content ?? 'Ocorreu um erro insperado.'),
          actions: <Widget>[
            // define os botões na base do dialogo
            ElevatedButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("Excluir"),
              onPressed: () async {
                try {
                  AlertDialogService().showLoader(context);
                  await APIService().deleteContent(id);
                  AlertDialogService().closeLoader(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const Home();
                  }));
                  AlertDialogService().showAlertDefault(
                      context, 'Sucesso!', 'Conteúdo deletado!');
                } catch (e) {
                  AlertDialogService().closeLoader(context);
                  AlertDialogService()
                      .showAlertDefault(context, 'Atenção!', e.toString());
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteContent(int id) async {
    showAlertConfirm(
        context, 'Atenção!', 'Deseja realmente excluir o conteúdo?', id);
  }
}
