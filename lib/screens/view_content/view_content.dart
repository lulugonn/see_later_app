import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_request_model.dart';
import 'package:see_later_app/models/content_response_model.dart';
import 'package:see_later_app/screens/home/home.dart';
import 'package:see_later_app/screens/nav_bar/nav_bar.dart';
import 'package:see_later_app/screens/widgets/button_widget.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';

import 'package:see_later_app/services/alert_dialog_service.dart';

class ViewContent extends StatefulWidget {
  const ViewContent(
      {super.key, required this.content, this.index, this.length});
  final ContentRequestModel content;
  final int? index;
  final num? length;

  @override
  State<ViewContent> createState() => _ViewContentState();
}

class _ViewContentState extends State<ViewContent> {
  late Future<ContentResponseModel?> _content;

  Future<ContentResponseModel?> _getContentById() async {
    return _content = APIService().getContentById(widget.content.id);
  }

  @override
  void initState() {
    super.initState();

    _getContentById();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ContentResponseModel?>(
        future: _content,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var items = snapshot.data;
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
                        _updateContent(items!);
                      },
                      child:
                          const Icon(Icons.save, color: Colors.white, size: 28),
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
                            Duration.zero, () => _deleteContent(items!.id!));
                      },
                      child: const Icon(Icons.delete,
                          color: Colors.white, size: 28),
                    ),
                  ],
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(Icons.link,
                                          color: Global.white, size: 30),
                                    ),
                                    title: Text(items!.title!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    subtitle: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 0.0),
                                      child: Text(
                                        items.type ?? '',
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    trailing: Tooltip(
                                      message: !items.favorite!
                                          ? 'Marcar como favorito'
                                          : 'Desmarcar como favorito',
                                      child: IconButton(
                                          onPressed: () =>
                                              {checkFavorite(items)},
                                          icon: !items.favorite!
                                              ? Icon(Icons.star_border)
                                              : Icon(Icons.star)),
                                    )),
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
                                      items.notes!,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 100,
                                    ))
                              ],
                            ),
                          ),
                          (items.categories != null)
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var category in items.categories!)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Chip(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              side: BorderSide(
                                                  color: Global.black),
                                            ),
                                            label: Text(category.name!),
                                            labelStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            backgroundColor: Global.black,
                                          ),
                                        )
                                    ],
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                ),
                          Row(
                            children: [
                              Text(
                                'Última atualização: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(items.updatedAt!)).toString()}',
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
                                    child: ButtonWidget(
                                        title: 'Copiar link',
                                        hasBorder: false,
                                        onTap: () {}),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: ButtonWidget(
                                        title: 'Acessar',
                                        hasBorder: false,
                                        onTap: () {}),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 50),
                          Ink(
                            decoration: !items.seen!
                                ? BoxDecoration(
                                    color: Global.darkGreen,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Global.darkGreen),
                                  )
                                : BoxDecoration(
                                    color: Global.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Global.darkGreen),
                                  ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                checkContent(items);
                              },
                              child: !items.seen!
                                  ? SizedBox(
                                      height: 45.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Icon(Icons.check,
                                                color: Global.white),
                                          ),
                                          Text('Marcar como visto',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Global.white)),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 45.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Icon(Icons.close,
                                                color: Global.darkGreen),
                                          ),
                                          Text('Desmarcar como visto',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Global.darkGreen)),
                                        ],
                                      ),
                                    ),
                            ),
                          )
                        ]))));
          } else {
            return Container();
          }
        });
  }

  void _updateContent(items) async {
    try {
      AlertDialogService().showLoader(context);
      await APIService().updateContent(items);
      AlertDialogService().closeLoader(context);

      AlertDialogService().showAlertDefault(
          context, 'Parabéns!', 'Conteúdo atualizado com sucesso!');
      setState(() {
        _content = _getContentById();
      });
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

  void checkContent(items) async {
    try {
      AlertDialogService().showLoader(context);
      await APIService().checkContent(items.id);

      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(
          context,
          'Parabéns!',
          items.seen
              ? 'Conteúdo desmarcado como visualizado!'
              : 'Conteúdo marcado como visto!');
      setState(() {
        _content = _getContentById();
      });
    } catch (e) {
      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(context, 'Atenção!', e.toString());
    }
  }

  void checkFavorite(items) async {
    try {
      AlertDialogService().showLoader(context);
      await APIService().checkFavorite(items.id);

      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(
          context,
          'Parabéns!',
          items.favorite
              ? 'Conteúdo retirado dos favoritos!'
              : 'Conteúdo favoritado!');
      setState(() {
        _content = _getContentById();
      });
    } catch (e) {
      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(context, 'Atenção!', e.toString());
    }
  }
}
