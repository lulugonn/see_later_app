import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/list_content_model.dart';
import 'package:see_later_app/screens/create_content/create_content.dart';
import 'package:see_later_app/screens/home/widgets/content_card.dart';
import 'package:see_later_app/screens/home/widgets/content_form.dart';
import 'package:see_later_app/screens/home/widgets/progress_card.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                return  const CreateContent();
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
                    appBar: const UserHeader(comeback: false, appBarTitle: 'Olá, Marcela!',),
                    body: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        children: [
                          ProgressCard(),
                          Padding(
                            padding: EdgeInsets.only(top: 40, bottom: 16),
                            child: Row(
                              children: const [
                                Text(
                                  'Últimos Conteúdos Salvos',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          (items?.length != 0)
                              ? _widgetContent(items!)
                              : _widgetEmpty()
                        ],
                      ),
                    )));
              } else {
                return Container();
              }
            }));
  }

  Widget _widgetEmpty() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: const [
          Icon(
            Icons.archive_outlined,
            size: 80,
          ),
          Text('Ainda não há conteúdo\ndisponível', textAlign: TextAlign.center)
        ],
      ),
    );
  }

  Widget _widgetContent(ListContentModel items) {
    return Column(children: [
      for (var i = 0; i < items.length; i++)
        ContentCard(
          content: items[i],
          index: i,
          length: items.length,
        ),
    ]);
  }
}
