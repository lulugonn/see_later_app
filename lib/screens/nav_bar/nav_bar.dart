import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/list_content_model.dart';
import 'package:see_later_app/screens/Home/widgets/content_card.dart';
import 'package:see_later_app/screens/home/home.dart';
import 'package:see_later_app/screens/home/widgets/content_form.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late Future<ListContentModel?> _listContent;
  int _currentIndex = 0;
  bool showUser = true;
  String appBarTitle = 'ola';

  final List<Widget> _screens = [
    const Home(),
    const ContentForm(),
    Container(),
  ];

  Future<ListContentModel?> _getLastContents() async {
    return _listContent = APIService().getLastContents();
  }

  @override
  void initState() {
    super.initState();
    _getLastContents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.white,
      appBar: UserHeader(
        comeback: false,
        appBarTitle: appBarTitle,
        showUser: showUser,
      ),
      // floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Global.mediumBlue,
      //   tooltip: 'Criar novo conteúdo',
      //   onPressed: () {
      //     showModalBottomSheet(
      //       context: context,
      //       builder: (builder) {
      //         return  const CreateContent();
      //       },
      //       isScrollControlled: true,
      //       backgroundColor: Colors.white,
      //       shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.add, color: Colors.white, size: 28),
      // ),
      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            switch (_currentIndex) {
              case 0:
                appBarTitle = 'ola';
                showUser = true;
                break;
              case 1:
                appBarTitle = 'Salvar Novo Conteúdo';
                showUser = true;
                break;
              case 2:
                appBarTitle = 'Salvar Novo Conteúdo';
                showUser = false;
                break;
            }
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: '',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Global.mediumBlue,
      ),
    );
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
