import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_request_model.dart';
import 'package:see_later_app/models/content_response_model.dart';
import 'package:see_later_app/models/tag_model.dart';
import 'package:see_later_app/screens/nav_bar/nav_bar.dart';
import 'package:see_later_app/screens/widgets/button_widget.dart';
import 'package:see_later_app/screens/widgets/textfield_widget.dart';
import 'package:see_later_app/screens/widgets/user_header_widget.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class EditContent extends StatefulWidget {
  const EditContent({super.key, required this.content});
  final ContentResponseModel content;

  @override
  State<EditContent> createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {
  late FutureOr<List<TagModel>> _listTag;
  late ContentRequestModel order;
  late List<TagModel> _selectedTags = [];
  late Future<ContentResponseModel?> _content;
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
  final TextEditingController _contentTitleKey = TextEditingController();
  final TextEditingController _contentTypeKey = TextEditingController();
  final TextEditingController _contentLinkKey = TextEditingController();
  final TextEditingController _contentNotesKey = TextEditingController();

  Future<ContentResponseModel?> _getContentById() async {
    return _content = APIService().getContentById(widget.content.id);
  }

  @override
  void initState() {
    super.initState();
    _getContentById();
    order = ContentRequestModel(id: widget.content.id);
    _selectedTags = [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ContentResponseModel?>(
        future: _content,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var items = snapshot.data;
            return Scaffold(
                appBar: UserHeader(
                  appBarTitle: 'Editar conteúdo',
                  comeback: true,
                  showUser: false,
                ),
                backgroundColor: Global.white,
                body: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 30),
                        child: Form(
                          key: _editFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextFieldWidget(
                                initialValue: items!.title,
                                obscureText: false,
                                prefixIconData: Icons.title,
                                hintText: 'Título',
                                validator: _validateInputTitle,
                                onSaved: (input) => order.title = input!,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: DropdownSearch<String>(
                                  popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    itemBuilder: (context, item, isSelected) {
                                      return ListTile(
                                        title: Text(
                                          item,
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                      );
                                    },
                                  ),
                                  items: ["Site", "Artigo", "Vídeo", 'Imagem'],
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    baseStyle: TextStyle(fontSize: 13),
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: "Tipo",
                                      labelStyle: TextStyle(fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Global.black, width: 0.5),
                                      ),
                                      fillColor: Global.white,
                                      filled: true,
                                      prefixIcon:
                                          Icon(Icons.filter_alt_outlined),
                                    ),
                                  ),
                                  selectedItem: items!.type,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: _validateInput,
                                  onSaved: (input) => order.type = input!,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: TextFieldWidget(
                                  initialValue: items.url,
                                  obscureText: false,
                                  prefixIconData: Icons.link,
                                  hintText: 'Link',
                                  validator: _validateInputUrl,
                                  onSaved: (input) => order.url = input!,
                                ),
                              ),
                              TextFieldWidget(
                                obscureText: false,
                                initialValue: items.notes,
                                prefixIconData: Icons.info,
                                hintText: 'Descricao',
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                onSaved: (input) => order.notes = input!,
                              ),
                            ],
                          ),
                        ),
                      ),
                      FlutterTagging<TagModel>(
                        initialItems: items.categories!,
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: InputDecoration(
                            labelText: 'Tags',
                            labelStyle: TextStyle(fontSize: 13),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Global.black, width: 0.5),
                            ),
                            fillColor: Global.white,
                            filled: true,
                          ),
                        ),
                        findSuggestions: _getTags,
                        additionCallback: (value) {
                          return TagModel(
                            name: value,
                          );
                        },
                        onAdded: (tag) async {
                          var aux = await _criarTag(tag.name);
                          return TagModel(name: tag.name, id: aux as int);
                        },
                        configureSuggestion: (lang) {
                          return SuggestionConfiguration(
                            title: Text(
                              lang.name!,
                              style: TextStyle(fontSize: 13),
                            ),
                            additionWidget: Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Set the border radius here
                                side: BorderSide(
                                    color: Global
                                        .black), // Optional: Customize border color
                              ),
                              avatar: Icon(
                                Icons.add_circle,
                                color: Colors.white,
                              ),
                              label: Text('Criar tag'),
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w300,
                              ),
                              backgroundColor: Global.black,
                            ),
                          );
                        },
                        configureChip: (lang) {
                          return ChipConfiguration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: Global.black),
                            ),
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            label: Text(lang.name!),
                            backgroundColor: Global.black,
                            labelStyle: TextStyle(color: Colors.white),
                            deleteIconColor: Colors.white,
                          );
                        },
                        onChanged: () {
                          setState(() {
                            _selectedTags = items.categories!;
                          });
                          var tagsId = [];
                          _selectedTags.forEach((tag) {
                            var aux = int.parse(tag.id.toString());
                            tagsId.add(aux);
                          });
                          setState(() {
                            order.categories = tagsId.cast<int>();
                          });
                        },
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: Global.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(width: 1, color: Colors.red),
                                  ),
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        Future.delayed(
                                            Duration.zero,
                                            () => _deleteContent(
                                                widget.content.id!));
                                      },
                                      child: SizedBox(
                                        height: 45.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Excluir conteúdo',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: Colors.red)),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 8.0),
                                child: ButtonWidget(
                                  fontSize: 12,
                                  title: 'Salvar mudanças',
                                  hasBorder: false,
                                  onTap: () async {
                                    if (validateAndSave()) {
                                      _updateContent();
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )));
          } else {
            return Container();
          }
        });
  }

  bool validateAndSave() {
    final form = _editFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor, preencha os dados";
    }
    return null;
  }

  String? _validateInputTitle(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor, preencha os dados";
    } else if(value.length > 50){
      return "O título só pode possuir até 50 caracteres";
    }
    return null;
  }

  String? _validateInputUrl(String? value) {
    if (!Uri.parse(value!).isAbsolute) {
      return "Por favor, insira um link válido. Exemplo: https://www.google.com";
    }
    return null;
  }

  void _updateContent() async {
    try {
      AlertDialogService().showLoader(context);
      await APIService().updateContent(order);
      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(
          context, 'Parabéns!', 'Conteúdo atualizado com sucesso!');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const NavBar();
      }));
    } catch (e) {
      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(context, 'Atenção!', e.toString());
    }
  }

  FutureOr<int?> _criarTag(name) async {
    try {
      AlertDialogService().showLoader(context);
      var id = await APIService().registerTag(name);
      AlertDialogService().closeLoader(context);

      AlertDialogService()
          .showAlertDefault(context, 'Parabéns!', 'Tag criada com sucesso!');
      return id;
    } catch (e) {
      AlertDialogService().closeLoader(context);
      AlertDialogService().showAlertDefault(context, 'Atenção!', e.toString());
    }
  }

  FutureOr<List<TagModel>> _getTags(String query) async {
    return await APIService().getTags();
  }

  void showAlertConfirm(BuildContext context, title, content, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Atenção!'),
          content: Text(content ?? 'Ocorreu um erro insperado.'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("Excluir"),
              onPressed: () async {
                try {
                  AlertDialogService().showLoader(context);
                  await APIService().deleteContent(id);
                  AlertDialogService().closeLoader(context);
                  AlertDialogService().showAlertDefault(
                      context, 'Sucesso!', 'Conteúdo deletado!');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBar(),
                    ),
                  );
                } catch (e) {
                  AlertDialogService().closeLoader(context);
                  AlertDialogService()
                      .showAlertDefault(context, 'Atenção!', e.toString());
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteContent(int id) async {
    showAlertConfirm(
        context, 'Atenção!', 'Deseja realmente excluir o conteúdo?', id);
  }
}
