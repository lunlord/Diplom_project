import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_trash_screen.dart';
import '../providers/trash_provider.dart';

class AdminTrashItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  AdminTrashItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditTrashScreen.routeName, arguments: id);
            },
            icon: Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: () async {
              try {
                await Provider.of<TrashProvider>(context, listen: false)
                    .deleteTrash(id);
              } catch (error) {
                scaffold.showSnackBar(
                  SnackBar(
                    content: Text('Удалить не получилось'),
                  ),
                );
              }
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
