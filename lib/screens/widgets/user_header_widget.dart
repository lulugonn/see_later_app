import 'package:flutter/material.dart';
import 'package:see_later_app/global.dart';

class UserHeader extends StatelessWidget implements PreferredSizeWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: AppBar(
          flexibleSpace: Container(),
          toolbarHeight: 120,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Global.white,
          title: const Text('Olá, Marcela!',
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
