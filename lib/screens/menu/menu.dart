import 'package:flutter/material.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const UserHeader(
          appBarTitle: 'Menu',
          comeback: true,
          showUser: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading:   Icon(Icons.tag, size: 25),

                  // Container(
                  //   padding: EdgeInsets.all(8.0),
                  //   decoration: BoxDecoration(
                  //       color: Color(0x66404040),
                  //       borderRadius: BorderRadius.circular(10)),)
                  
                  title: Text('Tags',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                 ),
                  ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading:   Icon(Icons.search, size: 25),
                  title: Text('Busca',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                 ),
                  ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading:   Icon(Icons.star, size: 25),
                  title: Text('Favoritos',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                 ),
                 ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading:   Icon(Icons.keyboard_double_arrow_up_rounded, size: 25),
                  title: Text('Progress',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                 ),
                 ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading:   Icon(Icons.timer, size: 25),
                  title: Text('Próximos conteúdos',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                 ),
                  ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading:   Icon(Icons.key, size: 25),
                  title: Text('Alterar senha',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                 ),
                  ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading:   Icon(Icons.door_back_door, size: 25),
                  title: Text('Sair',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                 ),
            ],
          ),
        )
    );
  }
}