import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashClean/providers/auth.dart';

import './screens/trash_overview_screen.dart';
import './screens/trash_detail_screen.dart';
import 'screens/cleaning_trash_screen.dart';
import './providers/trash_provider.dart';
import './screens/manage_trash_admin_screen.dart';
import './screens/edit_trash_screen.dart';
import './screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, TrashProvider>(
            update: (ctx, auth, previousTrash) => TrashProvider(
              auth.token,
              auth.userId,
              previousTrash == null ? [] : previousTrash.items,
            ),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
                primarySwatch: Colors.green,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato'),
            debugShowCheckedModeBanner: false,
            home: auth.isAuth ? TrashOverviewScreen() : AuthScreen(),
            routes: {
              TrashDetailScreen.routeName: (ctx) => TrashDetailScreen(),
              CleaningTrashScreen.routeName: (ctx) => CleaningTrashScreen(),
              ManageTrashAdmin.routeName: (ctx) => ManageTrashAdmin(),
              EditTrashScreen.routeName: (ctx) => EditTrashScreen(),
            },
          ),
        ));
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
