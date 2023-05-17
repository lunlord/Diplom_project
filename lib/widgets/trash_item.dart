import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashClean/providers/trash_provider.dart';
import '../screens/trash_detail_screen.dart';
import '../providers/trash.dart';

class TrashItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // TrashItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final trash = Provider.of<Trash>(context);
    final trashs = Provider.of<TrashProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              TrashDetailScreen.routeName,
              arguments: trash.id,
            );
          },
          child: Image.network(
            trash.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: FittedBox(
            child: Text(
              trash.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<Trash>(
            builder: (ctx, trash, _) => IconButton(
              icon: Icon(
                trash.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                trash.toggleFavoriteStatus();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Добавлено в избранное',
                        textAlign: TextAlign.center),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'Отменить',
                        onPressed: () {
                          trashs.removeSingleFavorite(trash.id);
                        }),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
