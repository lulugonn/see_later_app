import 'package:flutter/material.dart';
import 'package:see_later_app/global.dart';

class UserHeader extends StatelessWidget implements PreferredSizeWidget {
  const UserHeader(
      {super.key, required this.appBarTitle, required this.comeback});
  final String appBarTitle;
  final bool comeback;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          flexibleSpace: Container(),
          toolbarHeight: 120,
          automaticallyImplyLeading: comeback,
          elevation: 0,
          backgroundColor: Global.white,
          title: Text(appBarTitle,
              style: TextStyle(fontSize: 20, color: Global.black)),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(
                    Icons.account_circle_rounded,
                    size: 40,
                    color: Global.grey,
                  ),
                  focusColor: Global.black,
                  onPressed: () {},
                ))
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

  @override
// TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100);
}
