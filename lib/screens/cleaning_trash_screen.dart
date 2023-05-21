import 'package:flutter/material.dart';

class CleaningTrashScreen extends StatefulWidget {
  static const routeName = '/cleaning-trash';

  @override
  State<CleaningTrashScreen> createState() => _CleaningTrashScreenState();
}

class _CleaningTrashScreenState extends State<CleaningTrashScreen> {
  var _imageUrlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Отчет о проделанной работе'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FittedBox(
              child: Text('Пожалуйста, загрузите фотографию с места уборки',
                  style: TextStyle(fontSize: 20)),
            ),
            Form(child: TextFormField()),
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 8, right: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.green,
                ),
              ),
              child: _imageUrlController.text.isEmpty
                  ? Text('URL')
                  : FittedBox(
                      child: Image.network(_imageUrlController.text),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
