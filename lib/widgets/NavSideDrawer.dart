import 'package:flutter/material.dart';
import 'PathNavigator.dart';

class NavSideDrawer extends StatelessWidget {
  static String username;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: null,
            accountName: Text(username, style: TextStyle(fontSize: 27.0)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Text(
                username.substring(0, 1),
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            title: Text("Home", style: TextStyle(fontSize: 17.0)),
            onTap: () {
              Navigator.pop(context);
              navigateToSubPageHome(context);
            },
          ),
          ListTile(
            title: Text("Contact Us", style: TextStyle(fontSize: 17.0)),
            onTap: () {
              Navigator.pop(context);
              navigateToSubPageContact(context);
            },
          ),
          ListTile(
            title: Text("Logout", style: TextStyle(fontSize: 17.0)),
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
