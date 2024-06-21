import 'package:flutter/material.dart';
import 'package:see_later_app/controllers/auth_controller.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/screens/favorite/favorite_view/favorite_view.dart';
import 'package:see_later_app/screens/home/widgets/progress_card.dart';
import 'package:see_later_app/screens/onboarding/onboarding.dart';
import 'package:see_later_app/screens/search_content/search_content.dart';
import 'package:see_later_app/screens/tag/tag_view/tag_view.dart';
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
        appBar: UserHeader(
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
                leading: Icon(Icons.loyalty, size: 25),
                title: Text('Tags',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return TagView();
                  }));
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.star, size: 25),
                title: Text('Favoritos',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return FavoriteView();
                  }));
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.key, size: 25),
                title: Text('Alterar senha',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.logout, size: 25, color: Colors.red),
                title: Text('Sair',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.red)),
                onTap: () async {
                  await AuthController.removeToken();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return OnBoarding();
                  }));
                },
              ),
            ],
          ),
        ));
  }
}
