import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/models/list_content_model.dart';
import 'package:see_later_app/screens/home/widgets/content_card.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({super.key});

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  TextEditingController searchController = TextEditingController();
  static List previousSearchs = ['banana'];
  late Future<ListContentModel?> _listContent;
  bool showFilter = false;
  bool focusInput = false;
  List<String> tags = [];

  // list of string options
  List<String> options = [
    'Últimos 7 dias',
  ];

  Future<ListContentModel?> _getContent() async {
    setState(() {
      _listContent = APIService().getContent(searchController.text);
    });
    return _listContent;
  }

  @override
  void initState() {
    super.initState();
    _getContent();
  }

  previousSearchsItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Dismissible(
          key: GlobalKey(),
          onDismissed: (DismissDirection dir) {
            setState(() {});
            previousSearchs.removeAt(index);
          },
          child: Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                // color: SecondaryText,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(previousSearchs[index],
                  style: Theme.of(context).textTheme.bodyLarge!),
              const Spacer(),
              const Icon(
                Icons.close,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _widgetEmpty() {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: const [
            Icon(
              Icons.archive_outlined,
              size: 80,
            ),
            Text('Ainda não há conteúdo\ndisponível',
                textAlign: TextAlign.center)
          ],
        ),
      );
    }

    Widget _widgetContents(ListContentModel items) {
      return Column(children: [
        for (var i = 0; i < items.length; i++)
          ContentCard(
            content: items[i],
            index: i,
            length: items.length,
          ),
      ]);
    }

    return FutureBuilder<ListContentModel?>(
        future: _listContent,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final items = snapshot.data;
            return Scaffold(
                appBar: UserHeader(
                  comeback: false,
                  appBarTitle: '',
                  showUser: true,
                ),
                body: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Conteúdos',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              // child: SearchBar(
                              //   onFocusChange: (onFocus) => {
                              //     setState(() {
                              //       focusInput = onFocus!;
                              //     }),
                              //   },
                              //   controller: searchController,
                              //   prefixOnPressed: _getContent,
                              //   suffixOnPressed: () => {
                              //     setState(() {
                              //       searchController.text = "";
                              //       showFilter = false;
                              //     }),
                              //   },
                              // ),
                            ),
                          ),
                          IconButton(
                              onPressed: () => {
                                    setState(() {
                                      showFilter = !showFilter;
                                    })
                                  },
                              icon: Icon(Icons.filter_alt_sharp)),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      if (focusInput)
                        Container(
                          color: Colors.white,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: previousSearchs.length,
                              itemBuilder: (context, index) =>
                                  previousSearchsItem(index)),
                        ),
                      if (showFilter)
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Por data:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                ChipsChoice<String>.multiple(
                                  value: tags,
                                  onChanged: (val) =>
                                      setState(() => tags = val),
                                  choiceItems:
                                      C2Choice.listFrom<String, String>(
                                    source: options,
                                    value: (i, v) => v,
                                    label: (i, v) => v,
                                  ),
                                )
                              ],
                            )),
                      const SizedBox(
                        height: 8,
                      ),
                      (items?.length != 0)
                          ? _widgetContents(items!)
                          : _widgetEmpty()
                    ],
                  ),
                )));
          } else {
            return Container();
          }
        });
  }
}
