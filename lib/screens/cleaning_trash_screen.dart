import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashClean/providers/trash_provider.dart';
import '../widgets/image_input.dart';
import '../providers/trash.dart';

class CleaningTrashScreen extends StatefulWidget {
  static const routeName = '/cleaning-trash';
  final String id;
  CleaningTrashScreen({this.id});

  @override
  State<CleaningTrashScreen> createState() => _CleaningTrashScreenState();
}

class _CleaningTrashScreenState extends State<CleaningTrashScreen> {
  Trash _editedTrash;

  // var _imageUrlController = TextEditingController();
  @override
  void initState() {
    var trash = Trash(
      id: widget.id,
      title: Provider.of<TrashProvider>(context, listen: false)
          .findById(widget.id)
          .title,
      description: Provider.of<TrashProvider>(context, listen: false)
          .findById(widget.id)
          .description,
      imageUrl: Provider.of<TrashProvider>(context, listen: false)
          .findById(widget.id)
          .imageUrl,
    );
    _editedTrash = trash;
    super.initState();
  }

  void _selectImage(String pickedImage) {
    if (pickedImage != null) {
      _editedTrash.imageUrl = pickedImage;
    }
  }

  Future<void> _save() async {
    await Provider.of<TrashProvider>(context, listen: false)
        .updateTrash(widget.id, _editedTrash);
    Navigator.of(context).pop();
  }

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
            SizedBox(
              height: 10,
            ),
            Form(
              child: ImageInput(_selectImage),
              onChanged: () {
                _editedTrash.imageUrl = _editedTrash.imageUrl;
              },
            ),
            ElevatedButton.icon(
              onPressed: _save,
              icon: Icon(Icons.save),
              label: Text('Сохранить'),
            )
          ],
        ),
      ),
    );
  }
}
