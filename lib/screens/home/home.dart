import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/list_content_model.dart';
import 'package:see_later_app/screens/create_content/create_content.dart';
import 'package:see_later_app/screens/home/widgets/content_card.dart';
import 'package:see_later_app/screens/home/widgets/content_form.dart';
import 'package:see_later_app/screens/home/widgets/progress_card.dart';
import 'package:see_later_app/screens/search_content/search_content.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTab = 0;
  late Future<ListContentModel?> _listContent;

  Future<ListContentModel?> _getLastContents() async {
    return _listContent =
         APIService().getLastContents();
  }

  @override
  void initState() {
    super.initState();
    _getLastContents();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListContentModel?>(
        future: _listContent,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final items = snapshot.data;
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  (items != null && items.length != 0)
                      ? ProgressCard()
                      : Container(),
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
                  (items != null && items.length != 0)
                      ? _widgetLastContents(items)
                      : _widgetEmpty()
                ],
              ),
            ));
          } else {
            return Container();
          }
        });
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

  Widget _widgetLastContents(ListContentModel items) {
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
