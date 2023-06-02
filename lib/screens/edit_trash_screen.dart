import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashClean/models/place_location.dart';
import 'package:trashClean/providers/trash.dart';
import 'package:trashClean/providers/trash_provider.dart';
import 'package:trashClean/widgets/location_input.dart';
import '../widgets/image_input.dart';

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
  var _editedTrash = Trash(
    id: null,
    title: '',
    description: '',
    imageUrl: '',
  );
  PlaceLocation _pickedLocation;

  @override
  void initState() {
    _imageFocus.addListener(_updateImageUrl);
    // _editedTrash.location = _pickedLocation;
    super.initState();
  }

  void _selectImage(String pickedImage) {
    if (pickedImage != null) {
      _editedTrash.imageUrl = pickedImage;
    }
  }

  void _selectPlace(double lat, double long) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: long);
  }

  var _initValues = {
    'imageUrl': '',
    'title': '',
    'description': '',
  };
  var _isInit = true;
  var _isLoading = false;

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

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedTrash.id != null) {
      await Provider.of<TrashProvider>(context, listen: false)
          .updateTrash(_editedTrash.id, _editedTrash);
    } else {
      try {
        if (_pickedLocation != null) {
          // _editedTrash.location = _pickedLocation;
          await Provider.of<TrashProvider>(context, listen: false)
              .addTrash(_editedTrash, _pickedLocation);
        }
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Произошла ошибка'),
            content: Text('Что-то пошло не так'),
            actions: [
              TextButton(
                child: Text('Ок'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    ImageInput(_selectImage),
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
                    LocationInput(_selectPlace),
                    SizedBox(
                      height: 20,
                    ),
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
