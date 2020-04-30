import 'package:flutter/material.dart';
import 'PathNavigator.dart';

class AdminDrawer extends StatelessWidget {
  static String username = 'Admin';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: null,
            accountName: Text(username),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(
                username.substring(0, 1),
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () {
              Navigator.pop(context);
              navigateToSubPageLogout(context);
            },
          ),
        ],
      ),
    );
  }
}
