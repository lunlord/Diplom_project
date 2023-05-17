import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import 'package:trashClean/widgets/app_drawer.dart';
import '../widgets/trash_grid.dart';
import '../providers/trash_provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class TrashOverviewScreen extends StatefulWidget {
  @override
  State<TrashOverviewScreen> createState() => _TrashOverviewScreenState();
}

class _TrashOverviewScreenState extends State<TrashOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CleanTrash'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Только избранное'),
                      value: FilterOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('Показать все'),
                      value: FilterOptions.All,
                    ),
                  ])
        ],
      ),
      drawer: AppDrawer(),
      body: TrashGrid(_showOnlyFavorites),
    );
  }
}
