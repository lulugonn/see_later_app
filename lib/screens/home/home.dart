import 'package:flutter/material.dart';
import 'package:see_later_app/controllers/auth_controller.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/screens/widgets/button_widget.dart';
import 'package:see_later_app/screens/widgets/textfield_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  SizedBox(
                    width: 450,
                    height: 100,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                      leading: Icon(
                        Icons.subject,
                        size: 30,
                      ),
                      title: Text('Reunião dos pais'),
                      subtitle: Text(
                          'Endereço: Rua Tavares, 430, Méier. Dia: 17 de janeiro. Horário: 13h.'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  SizedBox(
                    width: 450,
                    height: 100,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                      leading: Icon(
                        Icons.link,
                        size: 30,
                      ),
                      title: Text('Viagem - Moscou'),
                      subtitle: Text(
                          'https://www.cvc.com.br/dicas-de-viagem/mundo/moscou/'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  SizedBox(
                    width: 450,
                    height: 100,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                      leading: Icon(
                        Icons.play_arrow,
                        size: 30,
                      ),
                      title: Text('Nutrição - Iorgute'),
                      subtitle:
                          Text('https://www.youtube.com/watch?v=o6i6SQBatD8'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    const Text(
      'Index 1: Business',
      style: optionStyle,
    ),
  ];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  late String? token;

  @override
  void initState() {
    super.initState();
    _token();
  }

  Future<void> _token() async{
    token = await AuthController.getToken();
    print(token);
  }

  @override
  Widget build(BuildContext context) {
      
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    List listItem = ['Texto', 'Link', 'Batata'];
    String valueChoose = 'Texto';
   

    return Scaffold(
      backgroundColor: Global.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Global.mediumBlue,
        tooltip: 'Criar nova nota',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Criar nota nota',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFieldWidget(
                        hintText: 'Título da nota',
                        obscureText: false,
                        prefixIconData: Icons.title,
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          border:  Border.all(color: Colors.grey, width:1),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: DropdownButton(
                          hint: Text('Selecione o tipo de nota'),
                          dropdownColor:  Global.backgroundColor,
                          focusColor: Global.backgroundColor,
                          icon: Icon(Icons.arrow_drop_down),
                          
                          iconSize: 36,
                          isExpanded: true,
                          value: valueChoose,
                          underline: SizedBox(),
                          items: listItem.map((valueItem) {
                            return DropdownMenuItem<String>(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              valueChoose = newValue.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextFieldWidget(
                        hintText: 'Descrição',
                        obscureText: false,
                        prefixIconData: Icons.description,
                        onChanged: (value) {},
                      ),
                    ),
                    ButtonWidget(
                    title: 'Salvar',
                    hasBorder: false,
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Home();
                      }));
                    }),
                  ],
                ),
              );
            },
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            )),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                //Header
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  children: [
                    Row(children: const [
                      Padding(
                        padding: EdgeInsets.only(),
                        child: Text('Olá, Marcela!',
                            style: TextStyle(fontSize: 28)),
                      ),
                    ]),
                    Container(
                      height: 20,
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView(
                                // This next line does the trick.
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Container(
                                    width: 60,
                                    margin: EdgeInsets.only(right: 5),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: const BoxDecoration(
                                      color: Global.mediumBlue,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40.0),
                                          bottomRight: Radius.circular(40.0),
                                          topLeft: Radius.circular(40.0),
                                          bottomLeft: Radius.circular(40.0)),
                                    ),
                                    child: const Text(
                                      "hello",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    margin: EdgeInsets.only(right: 5),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: const BoxDecoration(
                                      color: Global.mediumBlue,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40.0),
                                          bottomRight: Radius.circular(40.0),
                                          topLeft: Radius.circular(40.0),
                                          bottomLeft: Radius.circular(40.0)),
                                    ),
                                    child: const Text(
                                      "hello",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    margin: EdgeInsets.only(right: 5),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: const BoxDecoration(
                                      color: Global.mediumBlue,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40.0),
                                          bottomRight: Radius.circular(40.0),
                                          topLeft: Radius.circular(40.0),
                                          bottomLeft: Radius.circular(40.0)),
                                    ),
                                    child: const Text(
                                      "hello",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Row(
              children: [
                Center(
                  child: Home._widgetOptions.elementAt(_selectedIndex),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Página inicial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Global.mediumBlue,
      ),
    );
  }
}


