import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/list_content_model.dart';
import 'package:see_later_app/screens/home/widgets/content_card.dart';
import 'package:see_later_app/screens/home/widgets/content_form.dart';

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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text('Olá, Marcela!',
                                    style: TextStyle(fontSize: 28)),
                              ],
                            ),
                            Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Text(
                                    'Conteúdos',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      (items?.length != 0)
                          ? _widgetContent(items!)
                          : _widgetEmpty()
                    ],
                  ),
                );
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
        Center(
          child: ContentCard(content: items[i],
          ),
        ),
    ]);
  }
}
