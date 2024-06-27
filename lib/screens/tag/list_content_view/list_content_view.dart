import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/models/content_response_model.dart';
import 'package:see_later_app/models/list_content_response_model.dart';
import 'package:see_later_app/models/list_tag_model.dart';
import 'package:see_later_app/models/tag_model.dart';
import 'package:see_later_app/screens/home/widgets/content_card.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class ListContentView extends StatefulWidget {
  const ListContentView({Key? key, required this.tag}) : super(key: key);
  final TagModel tag;

  @override
  State<ListContentView> createState() => _ListContentViewState();
}

class _ListContentViewState extends State<ListContentView> {
  late Future<ListContentResponseModel?> _listContent;

  @override
  void initState() {
    super.initState();
    _listContent = _getAllTagContents();
  }

  Future<ListContentResponseModel?> _getAllTagContents() {
    return APIService().getAllTagContents(widget.tag.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListContentResponseModel?>(
      future: _listContent,
      builder: (context, AsyncSnapshot<ListContentResponseModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: UserHeader(
              appBarTitle: 'Menu > Tags > ${widget.tag.name}',
              comeback: true,
              showUser: false,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.items != null) {
          List<ContentResponseModel>? content = snapshot.data!.items;
          return Scaffold(
            appBar: UserHeader(
              appBarTitle: 'Menu > Tags > ${widget.tag.name}',
              comeback: true,
              showUser: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Column(children: [
                      for (var i = 0; i < content!.length; i++)
                        ContentCard(
                          content: content[i],
                          index: i,
                          length: content!.length,
                        ),
                    ]),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: UserHeader(
              appBarTitle: 'Menu > Tags > ${widget.tag.name}',
              comeback: true,
              showUser: false,
            ),
            body: Center(
              child: Text('Não há conteúdo relacionados a essa tag'),
            ),
          );
        }
      },
    );
  }

  void _deleteContent(int id) async {
    showAlertConfirm(
        context, 'Atenção!', 'Deseja realmente excluir o conteúdo?', id);
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
                    //_listContent = _getTags();
                  });
                  AlertDialogService()
                      .showAlertDefault(context, 'Sucesso!', 'Tag deletada!');
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

  // void _updateContent() async {
  //   try {
  //     AlertDialogService().showLoader(context);
  //     await APIService().updateContent(order);
  //     AlertDialogService().closeLoader(context);
  //     AlertDialogService().showAlertDefault(
  //         context, 'Parabéns!', 'Conteúdo atualizado com sucesso!');
  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //       return const NavBar();
  //     }));
  //   } catch (e) {
  //     AlertDialogService().closeLoader(context);
  //     AlertDialogService().showAlertDefault(context, 'Atenção!', e.toString());
  //   }
  // }
}
