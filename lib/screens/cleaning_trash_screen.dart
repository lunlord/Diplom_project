import 'package:flutter/material.dart';

class CleaningTrashScreen extends StatelessWidget {
  static const routeName = '/cleaning-trash';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Отчет о проделанной работе'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('пожалуйста загрузите фотографию с места уборки'),
          ),
          TextField()
        ],
      ),
    );
  }
}
