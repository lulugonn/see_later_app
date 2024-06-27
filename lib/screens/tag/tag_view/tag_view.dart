import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/models/list_tag_model.dart';
import 'package:see_later_app/models/tag_model.dart';
import 'package:see_later_app/screens/nav_bar/nav_bar.dart';
import 'package:see_later_app/screens/tag/list_content_view/list_content_view.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class TagView extends StatefulWidget {
  const TagView({Key? key}) : super(key: key);

  @override
  State<TagView> createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  late Future<ListTagModel?> _listTagFuture;

  @override
  void initState() {
    super.initState();
    _listTagFuture = _getTags();
  }

  Future<ListTagModel?> _getTags() async {
    return await APIService().getTag();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListTagModel?>(
      future: _listTagFuture,
      builder: (context, AsyncSnapshot<ListTagModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: UserHeader(
              appBarTitle: 'Menu > Tags',
              comeback: true,
              showUser: false,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.items != null) {
          List<TagModel>? tags = snapshot.data!.items;
          return Scaffold(
            appBar: UserHeader(
              appBarTitle: 'Menu > Tags',
              comeback: true,
              showUser: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Column(
                      children: tags!
                          .map((tag) => ListTile(
                            onTap: () => {
                              Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return ListContentView(tag: tag);
                                  }))
                            },
                              contentPadding: EdgeInsets.all(0),
                              title: Text(
                                tag.name!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              trailing: PopupMenuButton(
                                tooltip: "Opções",
                                offset: Offset(0.0, 60.0),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: Text("Editar"),
                                    onTap: () {},
                                  ),
                                  PopupMenuItem(
                                    child: Text("Excluir"),
                                    onTap: () {
                                      Future.delayed(Duration.zero,
                                          () => _deleteTag(tag.id!));
                                    },
                                  )
                                ],
                              )))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: UserHeader(
              appBarTitle: 'Menu > Tags',
              comeback: true,
              showUser: false,
            ),
            body: Center(
              child: Text('Não há tags cadastradas'),
            ),
          );
        }
      },
    );
  }

  void _deleteTag(int id) async {
    showAlertConfirm(
        context, 'Atenção!', 'Deseja realmente excluir a tag?', id);
  }

  void showAlertConfirm(BuildContext context, title, content, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Atenção!'),
          content: Text(content ?? 'Ocorreu um erro insperado.'),
          actions: <Widget>[
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
                  await APIService().deleteTag(id);
                  AlertDialogService().closeLoader(context);
                  Navigator.pop(context);

                  setState(() {
                    _listTagFuture = _getTags();
                  });
                  AlertDialogService().showAlertDefault(
                      context, 'Sucesso!', 'Tag deletada!');
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
}
