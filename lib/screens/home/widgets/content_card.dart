import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/models/content_model.dart';
import 'package:see_later_app/screens/home/home.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class ContentCard extends StatefulWidget {
  const ContentCard({super.key, required this.content});
  final ContentModel content;

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Icon(
          Icons.link,
          size: 30,
        ),
        title: Text(widget.content.title!),
        subtitle: Text(
          "${widget.content.url!} \n ${widget.content.notes!}",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        trailing: TextButton.icon(
          icon: Icon(Icons.delete),
          onPressed: () {
            _deleteContent(widget.content.id!);
          },
          label: Text(''),
        ),
        isThreeLine: true,
      ),
    );
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
