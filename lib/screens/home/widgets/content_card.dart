import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_request_model.dart';
import 'package:see_later_app/models/content_response_model.dart';
import 'package:see_later_app/screens/edit_content/edit_content.dart';
import 'package:see_later_app/screens/nav_bar/nav_bar.dart';
import 'package:see_later_app/screens/view_content/view_content.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class ContentCard extends StatefulWidget {
  const ContentCard(
      {super.key,
      required this.content,
      required this.index,
      required this.length});
  final ContentResponseModel content;
  final int index;
  final num length;

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                color: widget.index == widget.length - 1
                    ? Colors.transparent
                    : Global.grey, // Cor da borda
                width: 0.5,
              ),
            ),
          ),
          child: ListTile(
            onTap: () {
              Future.delayed(
                  Duration.zero,
                  () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ViewContent(
                          content: widget.content,
                          index: widget.index,
                          length: widget.length,
                        );
                      })));
            },
            contentPadding: EdgeInsets.all(0),
            leading: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: getColorItem(),
                    borderRadius: BorderRadius.circular(10)),
                child: getContentIcon(widget.content.type)),
            title: Text(widget.content.title!,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Text(
                widget.content.type ?? '',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(widget.content.createdAt!))
                    .toString()),
                PopupMenuButton(
                  tooltip: "Opções",
                  offset: Offset(0.0, 60.0),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Editar"),
                      onTap: () {
                        Future.delayed(
                            Duration.zero,
                            () => Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
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

  Icon getContentIcon(type) {
    switch (type.toLowerCase()) {
      case 'site':
        return Icon(Icons.public, color: Global.white, size: 30);
        break;
      case 'artigo':
        return Icon(Icons.book, color: Global.white, size: 30);
        break;
      case 'vídeo':
        return Icon(Icons.videocam, color: Global.white, size: 30);
        break;
      case 'imagem':
        return Icon(Icons.image, color: Global.white, size: 30);
        break;
      default:
        return Icon(Icons.notes, color: Global.white, size: 30);
        break;
    }
  }

  Color getColorItem() {
    List color = [
      const Color(0x80404040),
      const Color(0x999BE3AC),
      const Color(0x99ECC5EB),
      const Color(0x807098DA),
    ];
    return (color.toList()..shuffle()).first;
  }

  void _deleteContent(int id) async {
    showAlertConfirm(
        context, 'Atenção!', 'Deseja realmente excluir o conteúdo?', id);
  }
}
