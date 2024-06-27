import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_request_model.dart';
import 'package:see_later_app/models/tag_model.dart';
import 'package:see_later_app/screens/nav_bar/nav_bar.dart';
import 'package:see_later_app/screens/widgets/button_widget.dart';
import 'package:see_later_app/screens/widgets/textfield_widget.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class ContentForm extends StatefulWidget {
  const ContentForm({Key? key}) : super(key: key);

  @override
  State<ContentForm> createState() => _ContentFormState();
}

class _ContentFormState extends State<ContentForm> {
  late FutureOr<List<TagModel>> _listTag;
  late ContentRequestModel order;
  final GlobalKey<FormState> _contentFormKey = GlobalKey<FormState>();
  final TextEditingController _contentTitleKey = TextEditingController();
  final TextEditingController _contentTypeKey = TextEditingController();
  final TextEditingController _contentLinkKey = TextEditingController();
  final TextEditingController _contentNotesKey = TextEditingController();
  late List<TagModel> _selectedTags = [];

  @override
  void initState() {
    super.initState();
    order = ContentRequestModel();
    _selectedTags = [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _contentFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextFieldWidget(
                  hintText: 'Título do conteúdo',
                  obscureText: false,
                  prefixIconData: Icons.title,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: _validateInputTitle,
                  onSaved: (input) => order.title = input!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
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
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: TextStyle(fontSize: 13),
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Tipo",
                      labelStyle: TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Global.black, width: 0.5),
                      ),
                      fillColor: Global.white,
                      filled: true,
                      prefixIcon: Icon(Icons.filter_alt_outlined),
                    ),
                  ),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: _validateInput,
                  onSaved: (input) => order.type = input!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFieldWidget(
                  hintText: 'Link',
                  obscureText: false,
                  prefixIconData: Icons.link,
                  controller: _contentTypeKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: _validateInputUrl,
                  onSaved: (input) => order.url = input!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFieldWidget(
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: 9,
                  hintText: 'Descrição',
                  obscureText: false,
                  prefixIconData: Icons.info,
                  controller: _contentNotesKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (input) => order.notes = input!,
                ),
              ),
              FlutterTagging<TagModel>(
                initialItems: _selectedTags,
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    labelText: 'Tags',
                    labelStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Global.black, width: 0.5),
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
                    _selectedTags = _selectedTags;
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
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 100),
                child: ButtonWidget(
                  title: 'Salvar',
                  hasBorder: false,
                  onTap: () async {
                    if (validateAndSave()) {
                      _salvarConteudo();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _contentFormKey.currentState;
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

  void _salvarConteudo() async {
    try {
      AlertDialogService().showLoader(context);
      await APIService().registerContent(order);
      AlertDialogService().closeLoader(context);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const NavBar();
      }));
      AlertDialogService().showAlertDefault(
          context, 'Parabéns!', 'Conteúdo criado com sucesso!');
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
}
