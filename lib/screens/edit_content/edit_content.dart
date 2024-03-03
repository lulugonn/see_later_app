import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_model.dart';
import 'package:see_later_app/models/list_content_model.dart';
import 'package:see_later_app/screens/home/widgets/content_form.dart';
import 'package:see_later_app/screens/widgets/textfield_widget.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';

class EditContent extends StatefulWidget {
  const EditContent({super.key, required this.content});
  final ContentModel content;

  @override
  State<EditContent> createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {
  late Future<ListContentModel?> _listContent;

  Future<ListContentModel?> _getContent() async {
    return _listContent = APIService().getContent();
  }

  @override
  void initState() {
    super.initState();
    _getContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Global.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Global.mediumBlue,
          tooltip: 'Criar novo conteúdo',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (builder) {
                return const ContentForm();
              },
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            );
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Página inicial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
          selectedItemColor: Global.mediumBlue,
        ),
        body: FutureBuilder<ListContentModel?>(
            future: _listContent,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final items = snapshot.data;
                return Scaffold(
                    appBar: const UserHeader(
                      appBarTitle: 'Conteúdo',
                      comeback: true,
                    ),
                    body: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextFieldWidget(
                                  initialValue: widget.content.title,
                                  obscureText: false,
                                  prefixIconData: Icons.title,
                                  hintText: 'Título',
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: TextFieldWidget(
                                    initialValue: 'Artigo',
                                    obscureText: false,
                                    prefixIconData: Icons.filter_alt,
                                    hintText: 'Tipo',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: TextFieldWidget(
                                    initialValue: widget.content.url,
                                    obscureText: false,
                                    prefixIconData: Icons.link,
                                    hintText: 'Link',
                                  ),
                                ),
                                TextFieldWidget(
                                  initialValue: 'Quero correr hoje.',
                                  obscureText: false,
                                  prefixIconData: Icons.info,
                                  hintText: 'Descricao',
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
                               Row(children:[])
                             ],
                           ),

                          )
                        ],
                      ),
                    )));
              } else {
                return Container();
              }
            }));
  }
}
