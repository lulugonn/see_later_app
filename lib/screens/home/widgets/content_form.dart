import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_model.dart';
import 'package:see_later_app/screens/home/widgets/_chip.dart';
import 'package:see_later_app/screens/nav_bar/nav_bar.dart';
import 'package:see_later_app/screens/widgets/button_widget.dart';
import 'package:see_later_app/screens/widgets/textfield_widget.dart';
import 'package:see_later_app/services/alert_dialog_service.dart';

class ContentForm extends StatefulWidget {
  const ContentForm({super.key});

  @override
  State<ContentForm> createState() => _ContentFormState();
}

class _ContentFormState extends State<ContentForm> {
  late ContentModel order;
  late String selected = 'Luaa';
  final GlobalKey<FormState> _contentFormKey = GlobalKey<FormState>();
  final TextEditingController _contentTitleKey = TextEditingController();
  final TextEditingController _contentTypeKey = TextEditingController();
  final TextEditingController _contentLinkKey = TextEditingController();
  final TextEditingController _contentNotesKey = TextEditingController();
  late List<String> values = [];

  @override
  void initState() {
    super.initState();
    order = ContentModel();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _contentFormKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextFieldWidget(
                  hintText: 'Título do conteúdo',
                  obscureText: false,
                  prefixIconData: Icons.title,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: _validateInput,
                  onSaved: (input) => order.title = input),
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
                        style: TextStyle(
                            fontSize:
                                13.0), // Change font size for dropdown options here
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
                onSaved: (input) => order.type = input,
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
                  validator: _validateInput,
                  onSaved: (input) => order.url = input),
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
                  validator: _validateInput,
                  onSaved: (input) => order.notes = input),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: const [
                  Text(
                    'Tags:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            TagEditor(
              length: values.length,
              delimiters: [','],
              textInputAction: TextInputAction.next,
              hasAddButton: true,
              textStyle: TextStyle(fontSize: 13),
              inputDecoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Global.black, width: 0.5),
                ),
                fillColor: Global.white,
                filled: true,
                labelText: "Criar tag",
                labelStyle: TextStyle(fontSize: 13),
              ),
              onTagChanged: (newValue) {
                setState(() {
                  values.add(newValue);
                });
              },
              tagBuilder: (context, index) => ChipRead(
                index: index,
                label: values[index],
                onDeleted: (index) {
                  setState(() {
                    values.removeAt(index);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ButtonWidget(
                  title: 'Salvar',
                  hasBorder: false,
                  onTap: () async {
                    if (validateAndSave()) {
                      _salvarConteudo();
                    }
                  }),
            ),
          ])),
    ));
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
    if (value == null || value!.length == 0) {
      return "Por favor, preencha os dados";
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
}
