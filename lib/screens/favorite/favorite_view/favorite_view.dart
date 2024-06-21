import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/models/list_content_model.dart';
import 'package:see_later_app/models/list_content_response_model.dart';
import 'package:see_later_app/screens/home/widgets/content_card.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  late Future<ListContentResponseModel?> _listContent;

  Future<ListContentResponseModel?> _getAllFavoriteContents() async {
    return _listContent = APIService().getAllContents(true);
  }

  @override
  void initState() {
    super.initState();
    _getAllFavoriteContents();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListContentResponseModel?>(
      future: _listContent,
      builder: (context,  AsyncSnapshot<ListContentResponseModel?>  snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: UserHeader(
              appBarTitle: 'Menu > Favoritos',
              comeback: true,
              showUser: false,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          var items = snapshot.data;
          return Scaffold(
            appBar: UserHeader(
              appBarTitle: 'Menu > Favoritos',
              comeback: true,
              showUser: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(children: [
                  for (var i = 0; i < items!.length; i++)
                    ContentCard(
                      content: items[i],
                      index: i,
                      length: items.length,
                    ),
                ]),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: UserHeader(
              appBarTitle: 'Menu > Favoritos',
              comeback: true,
              showUser: false,
            ),
            body: Center(
              child: Text('Não há conteúdo favoritado!'),
            ),
          );
        }
      },
    );
  }
}
