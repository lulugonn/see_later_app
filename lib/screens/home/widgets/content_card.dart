import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_model.dart';
import 'package:see_later_app/screens/edit_content/edit_content.dart';
import 'package:see_later_app/screens/home/home.dart';
import 'package:see_later_app/screens/nav_bar/nav_bar.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class ContentCard extends StatefulWidget {
  const ContentCard(
      {super.key,
      required this.content,
      required this.index,
      required this.length});
  final ContentModel content;
  final int index;
  final num length;

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.index == widget.length - 1
                    ? Colors.transparent
                    : Global.grey, // Cor da borda
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
              child: const Icon(Icons.link, color: Global.white, size: 30),
            ),
            title: Text(widget.content.title!,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                widget.content.type?? '',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text( DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.content.createdAt!)).toString()),
                PopupMenuButton(
                  tooltip: "Opções",
                  offset: Offset(0.0, 60.0),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Editar"),
                      onTap: () {
                        Future.delayed(
                            Duration.zero,
                            () => Navigator.of(context).push(
                                    // PageTransition(
                                    //   child: EditContent(
                                    //     content: widget.content,
                                    //   ),
                                    //   type: PageTransitionType
                                    //       .leftToRight, // Tipo de animação
                                    //   duration: Duration(
                                    //       milliseconds:
                                    //           500), // Duração da animação
                                    // ),
                                    MaterialPageRoute(builder: (context) {
                                  return EditContent(
                                    content: widget.content,
                                  );
                                })));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Excluir"),
                      onTap: () {
                        Future.delayed(Duration.zero,
                            () => _deleteContent(widget.content.id!));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
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
                    return const NavBar();
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
