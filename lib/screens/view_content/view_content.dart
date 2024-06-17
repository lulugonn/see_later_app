import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_model.dart';
import 'package:see_later_app/screens/edit_content/edit_content.dart';
import 'package:see_later_app/screens/home/home.dart';
import 'package:see_later_app/screens/nav_bar/nav_bar.dart';
import 'package:see_later_app/screens/widgets/button_widget.dart';
import 'package:see_later_app/screens/widgets/textfield_widget.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class ViewContent extends StatefulWidget {
  const ViewContent(
      {super.key, required this.content, this.index, this.length});
  final ContentModel content;
  final int? index;
  final num? length;

  @override
  State<ViewContent> createState() => _ViewContentState();
}

class _ViewContentState extends State<ViewContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UserHeader(
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
                Future.delayed(
                    Duration.zero, () => _deleteContent(widget.content.id!));
              },
              child: const Icon(Icons.delete, color: Colors.white, size: 28),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: '',
          ),
        ],
          selectedItemColor: Global.mediumBlue,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(children: [
                  Card(
                      color: Global.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: Color(0x66404040),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.link,
                                color: Global.white, size: 30),
                          ),
                          title: Text(widget.content.title!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Text(
                              widget.content.type ?? '',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.content.notes!,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 100,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Chip(label: Text('faculdade')))
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Última atualização: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.content.updatedAt!)).toString()}',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
         Container(
          padding: EdgeInsets.only(top: 20.0),
          height: 100,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child:  ButtonWidget(
                      title: 'Copiar link',
                      hasBorder: false,
                      onTap: () {
                      }),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child:  ButtonWidget(
                      title: 'Acessar',
                      hasBorder: false,
                      onTap: () {
                      }),
                ),
              )
            ],
          ),
        )            ]))));
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

  void checkContent() async {
    try {
      AlertDialogService().showLoader(context);
      await APIService().checkContent(widget.content.id);
      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(
          context, 'Parabéns!', 'Conteúdo visto com sucesso!');
    } catch (e) {
      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(context, 'Atenção!', e.toString());
    }
  }
}
