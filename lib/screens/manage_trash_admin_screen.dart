import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashClean/screens/edit_trash_screen.dart';
import '../providers/trash_provider.dart';
import '../widgets/admin_trash_item.dart';
import '../widgets/app_drawer.dart';

class ManageTrashAdmin extends StatelessWidget {
  static const routeName = '/manage-trash';
  @override
  Widget build(BuildContext context) {
    final trashData = Provider.of<TrashProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Управление мусором'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditTrashScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: trashData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              AdminTrashItem(
                trashData.items[i].id,
                trashData.items[i].title,
                trashData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
