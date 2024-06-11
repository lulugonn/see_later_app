import 'package:flutter/material.dart';
import 'package:see_later_app/controllers/auth_controller.dart';
import 'package:see_later_app/global.dart';
import 'package:see_later_app/screens/menu/menu.dart';

class UserHeader extends StatefulWidget implements PreferredSizeWidget {
   UserHeader(
      {super.key,
      required this.appBarTitle,
      required this.comeback,
      required this.showUser});
  final String appBarTitle;
  final bool comeback;
  final bool showUser;

  @override
  State<UserHeader> createState() => _UserHeaderState();

  @override
// TODO: implement preferredSize
    Size get preferredSize => const Size.fromHeight(kToolbarHeight + 50);

}

class _UserHeaderState extends State<UserHeader> {
  late Future<String?> _name;

  Future<String?> _getName() async {
    return _name = AuthController.getName();
  }

  @override
  void initState() {
    super.initState();
    _getName();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(300),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 30),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          flexibleSpace: Container(),
          automaticallyImplyLeading: widget.comeback,
          elevation: 0,
          backgroundColor: Global.white,
          title: Text(widget.appBarTitle,
              style: TextStyle(fontSize: 20, color: Global.black)),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: (widget.showUser)
                    ? IconButton(
                        icon: const Icon(
                          Icons.account_circle_rounded,
                          size: 40,
                          color: Global.grey,
                        ),
                        focusColor: Global.black,
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Menu();
                          }));
                        },
                      )
                    : Container())
          ],
        ),
      ),
    );
    //               ),(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: const [
    //     Icon(Icons.account_circle_rounded)
    //   ],
    // );
  }


}
