import 'package:flutter/material.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/screens/home/widgets/content_card.dart';
import 'package:see_later_app/screens/home/widgets/content_form.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String? token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Global.mediumBlue,
        tooltip: 'Criar nova nota',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (builder) {
              return const ContentForm();
            },
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(),
                        child: Text('Olá, Marcela!', style: TextStyle(fontSize: 28)),
                      ),
                    ],
                  ),
                  ],
              ),
            ),
            
                Column(
                  children: [
                    Center(
                      child: ContentCard(title: 'Luana', notes: 'google.com',),
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
        selectedItemColor: Global.mediumBlue,
      ),
    );
  }
}
