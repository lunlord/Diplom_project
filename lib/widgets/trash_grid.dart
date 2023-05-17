import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/trash_provider.dart';
import '../widgets/trash_item.dart';

class TrashGrid extends StatelessWidget {
  final bool showFavor;

  TrashGrid(this.showFavor);

  @override
  Widget build(BuildContext context) {
    final trashData = Provider.of<TrashProvider>(context);
    final trashs = showFavor ? trashData.favoritesTrash : trashData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: trashs.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: trashs[i],
        child: TrashItem(
            // trashs[i].id,
            // trashs[i].title,
            // trashs[i].imageUrl,
            ),
      ),
    );
  }
}
