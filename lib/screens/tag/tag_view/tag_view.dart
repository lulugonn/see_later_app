import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/models/list_tag_model.dart';
import 'package:see_later_app/models/tag_model.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';

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
                      children:
                       tags!.map((tag) => ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          tag.name!, 
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        trailing: PopupMenuButton(
                          tooltip: 'Options',
                          offset: Offset(0.0, 60.0),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('Edit'),
                              onTap: () {
                                // Handle edit action
                              },
                            ),
                          ],
                        ),
                      )).toList(),
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
}