import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashClean/providers/trash_provider.dart';
import '../providers/trash.dart';
import '../screens/cleaning_trash_screen.dart';

class TrashDetailScreen extends StatefulWidget {
  // final String title;

  // TrashDetailScreen(this.title);
  static const routeName = '/trash-detail';

  @override
  State<TrashDetailScreen> createState() => _TrashDetailScreenState();
}

class _TrashDetailScreenState extends State<TrashDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final trashId = ModalRoute.of(context).settings.arguments as String;
    final loadedTrash = Provider.of<TrashProvider>(
      context,
      listen: false,
    ).getTrashById(trashId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedTrash.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                      Image.network(loadedTrash.imageUrl, fit: BoxFit.cover)),
              width: double.infinity,
              margin: EdgeInsets.all(10),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        loadedTrash.title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 70,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () => setState(() {
                            loadedTrash.toggleFavoriteStatus();
                          }),
                          icon: loadedTrash.isFavorite
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border_outlined),
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 30),
                        child: Text(loadedTrash.description),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(CleaningTrashScreen.routeName),
                          child: Text('Отчитаться об уборке'),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
