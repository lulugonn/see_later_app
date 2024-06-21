import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/filter_model.dart';
import 'package:see_later_app/models/list_content_response_model.dart';
import 'package:see_later_app/models/tag_model.dart';
import 'package:see_later_app/screens/home/widgets/content_card.dart';
import 'package:see_later_app/screens/widgets/button_widget.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({Key? key}) : super(key: key);

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  TextEditingController searchController = TextEditingController();
  static List previousSearchs = ['banana'];
  TextEditingController textController = TextEditingController();
  late List<TagModel> _selectedTags = [];
  late Future<ListContentResponseModel?> _listContent;
  bool showFilter = false;
  bool focusInput = false;
  List<String> tags = [];
  late FilterModel? filter;
  late int value;

  @override
  void initState() {
    super.initState();
    _selectedTags = [];
    _loadTags();
    filter = FilterModel();
    value = 1;
    _getContent(); // Correção: Inicialização correta de _listContent
  }

  Future<ListContentResponseModel?> _getContent() async {
   return _listContent=   APIService().getContent(filter!); // Correção: Chamada correta para APIService().getContent()
  }

  Future<void> _loadTags() async {
    List<TagModel> tags = await _getTags();
    setState(() {
      _selectedTags = tags;
    });
  }

  Widget previousSearchsItem(int index) {
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
                  style: Theme.of(context).textTheme.bodyLarge),
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
    final size = MediaQuery.of(context).size;

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

    Widget _widgetContents(ListContentResponseModel items) {
      return Column(children: [
        for (var i = 0; i < items.length; i++)
          ContentCard(
            content: items[i],
            index: i,
            length: items.length,
          ),
      ]);
    }

    return FutureBuilder<ListContentResponseModel?>(
      future: _listContent,
      builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ));
        } else
        if (snapshot.connectionState == ConnectionState.done) {
          final items = snapshot.data;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
               SearchAnchor(builder:
                      (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                      trailing: <Widget>[
                        Tooltip(
                          message: 'Filtros avançados',
                          child: IconButton(
                              onPressed: () => {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (builder) {
                                        return StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter setState) {
                                            return Container(
                                              padding: EdgeInsets.all(40),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 20.0),
                                                    child: DropdownSearch<String>(
                                                      popupProps: PopupProps.menu(
                                                        showSelectedItems: true,
                                                        itemBuilder: (context, item,
                                                            isSelected) {
                                                          return ListTile(
                                                            title: Text(
                                                              item,
                                                              style: TextStyle(
                                                                  fontSize: 13.0),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      items: [
                                                        "Hoje",
                                                        "Últimos 7 dias",
                                                        "Último mês",
                                                        'Último ano',
                                                        'Personalizado'
                                                      ],
                                                      dropdownDecoratorProps:
                                                          DropDownDecoratorProps(
                                                        baseStyle:
                                                            TextStyle(fontSize: 13),
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          labelText: "Período",
                                                          labelStyle: TextStyle(
                                                              fontSize: 13),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                            borderSide: BorderSide(
                                                                color: Global.black,
                                                                width: 0.5),
                                                          ),
                                                          fillColor: Global.white,
                                                          filled: true,
                                                          prefixIcon: Icon(Icons
                                                              .filter_alt_outlined),
                                                        ),
                                                      ),
                                                      autoValidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      //     validator: _validateInput,
                                                      //   onSaved: (input) => order.type = input!,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 20.0),
                                                    child: DropdownSearch<String>(
                                                      popupProps: PopupProps.menu(
                                                        showSelectedItems: true,
                                                        itemBuilder: (context, item,
                                                            isSelected) {
                                                          return ListTile(
                                                            title: Text(
                                                              item,
                                                              style: TextStyle(
                                                                  fontSize: 13.0),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      items: [
                                                        "Site",
                                                        "Artigo",
                                                        "Vídeo",
                                                        'Imagem'
                                                      ],
                                                      dropdownDecoratorProps:
                                                          DropDownDecoratorProps(
                                                        baseStyle:
                                                            TextStyle(fontSize: 13),
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          labelText: "Tipo",
                                                          labelStyle: TextStyle(
                                                              fontSize: 13),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                            borderSide: BorderSide(
                                                                color: Global.black,
                                                                width: 0.5),
                                                          ),
                                                          fillColor: Global.white,
                                                          filled: true,
                                                          prefixIcon: Icon(Icons
                                                              .filter_alt_outlined),
                                                        ),
                                                      ),
                                                      autoValidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      //     validator: _validateInput,
                                                      //   onSaved: (input) => order.type = input!,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Tags',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  ChipsChoice<int>.single(
                                                    value: value,
                                                    onChanged: (val) {
                                                      setState(() => value = val);
                                                    },
                                                    choiceLoader: getChoices,
                                                    wrapped: true,
                                                    choiceCheckmark: true,
                                                    choiceStyle: C2ChipStyle(
                                                      //labelStyle: TextStyle(color: Colors.white),
                                                      backgroundColor: Global.white,
                                                      borderColor: Global.black,
                                                      borderStyle: BorderStyle.solid,
                                                      //  borderColor:
                                                      //                                                   OutlineInputBorder(
                                                      //                                                 borderRadius:
                                                      //                                                     BorderRadius.all(
                                                      //                                                         Radius.circular(
                                                      //                                                             10.0)),
                                                      //                                                 borderSide: BorderSide(
                                                      //                                                     color: Global.black,
                                                      //                                                     width: 0.5),
                                                      //                                               ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0)),
                                                      //selectedColor: Colors.green,
                                                      //brightness: Brightness.dark,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Incluir conteúdos já consumidos',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Switch(
                                                      value: filter!.seen!=null?filter!.seen! :false,
                                                        activeColor: Colors.blue,
                                                        onChanged: (bool value) {
                                                          setState(() {
                                                            filter!.seen = value;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.only(top: 20.0),
                                                    height: 100,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            child: Ink(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Global.white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: Global
                                                                        .mediumBlue),
                                                              ),
                                                              child: InkWell(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  onTap: () {},
                                                                  child: SizedBox(
                                                                    height: 45.0,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            'Limpar filtros',
                                                                            textAlign:
                                                                                TextAlign
                                                                                    .left,
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight
                                                                                    .bold,
                                                                                fontSize:
                                                                                    12,
                                                                                color:
                                                                                    Global.mediumBlue)),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 8.0),
                                                            child: ButtonWidget(
                                                                fontSize: 14,
                                                                title:
                                                                    'Aplicar filtros',
                                                                hasBorder: false,
                                                                onTap: ()  {
                                                                  setState(()async {    _listContent= _getContent();
      });
         Navigator.of(context).pop();

                                                                }),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        );
                                      },
                                      isScrollControlled: true,
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                      ),
                                    ),
                                    setState(() {
                                      showFilter = !showFilter;
                                    })
                                  },
                              icon: Icon(Icons.filter_alt_sharp)),
                        )
                      ],
                    );
                  }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(5, (int index) {
                      final String item = 'item $index';
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            controller.closeView(item);
                          });
                        },
                      );
                    });
                  }),

                  // Flexible(

                  //  child: SearchBar(),
                  // ),
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
                            previousSearchsItem(index),
                      ),
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  (items?.length != 0)
                      ? _widgetContents(items!)
                      : _widgetEmpty()
                ],
              ),
            ),
          );
        } else {
          return Container(); // Aqui pode ser mostrado um indicador de carregamento, se desejado
        }
      },
    );
  }

  Future<List<C2Choice<int>>> getChoices() async {
    var res = await APIService().getTags();
    List<C2Choice<int>> choices = res.map((tag) {
      return C2Choice<int>(
        meta: res,
        value: tag.id!,
        label: tag.name!,
      );
    }).toList();

    // choices.insert(0, C2Choice<String>(value: 'all', label: 'All'));

    return choices;
  }

  Future<List<TagModel>> _getTags() async {
    return await APIService().getTags();
  }
}