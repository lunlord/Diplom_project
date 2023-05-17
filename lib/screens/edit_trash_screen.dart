import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashClean/providers/trash.dart';
import 'package:trashClean/providers/trash_provider.dart';

class EditTrashScreen extends StatefulWidget {
  static const routeName = '/edit-trash';
  @override
  State<EditTrashScreen> createState() => _EditTrashScreenState();
}

class _EditTrashScreenState extends State<EditTrashScreen> {
  final _titleFocus = FocusNode();
  var _imageUrlController = TextEditingController();
  final _imageFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedTrash = Trash(id: null, title: '', description: '', imageUrl: '');

  @override
  void initState() {
    _imageFocus.addListener(_updateImageUrl);
    super.initState();
  }

  var _initValues = {
    'imageUrl': '',
    'title': '',
    'description': '',
  };
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final trashId = ModalRoute.of(context).settings.arguments as String;
      if (trashId != null) {
        _editedTrash = Provider.of<TrashProvider>(context, listen: false)
            .findById(trashId);
        _initValues = {
          //'imageUrl': _editedTrash.imageUrl,
          'imageUrl': '',
          'title': _editedTrash.title,
          'description': _editedTrash.description,
        };
        _imageUrlController.text = _editedTrash.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageFocus.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedTrash.id != null) {
      Provider.of<TrashProvider>(context, listen: false)
          .updateTrash(_editedTrash.id, _editedTrash);
    } else {
      Provider.of<TrashProvider>(context, listen: false).addTrash(_editedTrash);
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlController.dispose();
    _imageFocus.dispose();
    _imageFocus.removeListener(_updateImageUrl);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                  Expanded(
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Ссылка на картинку'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_titleFocus);
                      },
                      controller: _imageUrlController,
                      focusNode: _imageFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Введите URL';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _editedTrash = Trash(
                          id: _editedTrash.id,
                          title: _editedTrash.title,
                          description: _editedTrash.description,
                          imageUrl: newValue,
                          isCleaned: _editedTrash.isCleaned,
                          isFavorite: _editedTrash.isFavorite,
                        );
                      },
                    ),
                  )
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Название'),
                initialValue: _initValues['title'],
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите название';
                  }
                  if (value.length < 5) {
                    return 'Название не может быть меньше 5-ти символов';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (newValue) {
                  _editedTrash = Trash(
                    id: _editedTrash.id,
                    title: newValue,
                    description: _editedTrash.description,
                    imageUrl: _editedTrash.imageUrl,
                    isCleaned: _editedTrash.isCleaned,
                    isFavorite: _editedTrash.isFavorite,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Описание'),
                initialValue: _initValues['description'],
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Введите описание';
                  }
                  if (value.length < 10) {
                    return 'Описание не может быть меньше 10-ти символов';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _editedTrash = Trash(
                    id: _editedTrash.id,
                    title: _editedTrash.title,
                    description: newValue,
                    imageUrl: _editedTrash.imageUrl,
                    isCleaned: _editedTrash.isCleaned,
                    isFavorite: _editedTrash.isFavorite,
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: Icon(Icons.save),
                label: Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
