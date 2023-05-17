import 'package:flutter/material.dart';
import 'package:trashClean/screens/manage_trash_admin_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Меню'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.accessibility_sharp),
            title: Text('Лента'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Управление лентой'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ManageTrashAdmin.routeName);
            },
          ),
        ],
      ),
    );
  }
}
