import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/trash_overview_screen.dart';
import './screens/trash_detail_screen.dart';
import 'screens/cleaning_trash_screen.dart';
import './providers/trash_provider.dart';
import './screens/manage_trash_admin_screen.dart';
import './screens/edit_trash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TrashProvider(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: MyHomePage(),
        routes: {
          TrashDetailScreen.routeName: (ctx) => TrashDetailScreen(),
          CleaningTrashScreen.routeName: (ctx) => CleaningTrashScreen(),
          ManageTrashAdmin.routeName: (ctx) => ManageTrashAdmin(),
          EditTrashScreen.routeName: (ctx) => EditTrashScreen()
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TrashOverviewScreen(),
      ),
    );
  }
}
