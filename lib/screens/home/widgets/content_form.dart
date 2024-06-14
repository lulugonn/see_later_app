import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:see_later_app/api/api_service.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/models/content_model.dart';
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
                  controller: _contentTitleKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: _validateInput,
                  onSaved: (input) => order.title = input),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: DropdownSearch<String>(
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                ),
                items: ["Site", "Artigo", "Vídeo", 'Imagem'],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Tipo",
                    hintText: "Tipo",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Global.black, width: 0.5),
                    ),
                    fillColor: Global.white,
                    filled: true,
                    prefixIcon:Icon(Icons.filter_alt_outlined),
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
            ButtonWidget(
                title: 'Salvar',
                hasBorder: false,
                onTap: () async {
                  if (validateAndSave()) {
                    _salvarConteudo();
                  }
                }),
          ])),
    ));
    // return SingleChildScrollView(
    //   child: Container(
    //               padding: EdgeInsets.all(20),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   const Padding(
    //                     padding: EdgeInsets.all(8.0),
    //                     child: Text(
    //                       'Criar conteúdo',
    //                       style: TextStyle(fontSize: 20),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
    //                     child: TextFieldWidget(
    //                       hintText: 'Título do conteúdo',
    //                       obscureText: false,
    //                       prefixIconData: Icons.title,
    //                       onChanged: (value) {
    //                         setState(() {
    //                           order.title = value;
    //                         });
    //                       },
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(bottom: 20.0),
    //                     child: TextFieldWidget(
    //                       hintText: 'URL',
    //                       obscureText: false,
    //                       prefixIconData: Icons.link,
    //                       onChanged: (value) {
    //                         setState(() {
    //                           order.url = value;
    //                         });
    //                       },
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(bottom: 20.0),
    //                     child: TextFieldWidget(
    //                       hintText: 'Tipo',
    //                       obscureText: false,
    //                       prefixIconData: Icons.filter_alt_outlined,
    //                       onChanged: (value) {
    //                         setState(() {
    //                           order.type = value;
    //                         });
    //                       },
    //                     ),
    //                   ),

    //
    //                   ButtonWidget(
    //                       title: 'Salvar',
    //                       hasBorder: false,
    //                       onTap: () {
    //                         _salvarConteudo();
    //                       }),
    //                 ],
    //               ),
    //             ),
    // );
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
