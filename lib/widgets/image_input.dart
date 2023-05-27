import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectedImage;
  ImageInput(this.onSelectedImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  String imageUrl;

  // Future _uploadFile() async {
  //   final path = 'files/${_storedImage.uri}';
  //   final file = File(_storedImage.path);

  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   ref.putFile(file);
  // }

  Future _takePicture() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _storedImage = File(imageFile.path);
    });

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_storedImage);
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((url) {
        widget.onSelectedImage(url);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'Изображение не выбрано',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () {
              _takePicture();
            },
            label: Text('Сфотографировать'),
            icon: Icon(Icons.camera),
          ),
        ),
        // Expanded(
        //   child: TextButton.icon(
        //     onPressed: () {
        //       // _uploadFile();
        //     },
        //     label: Text('Загрузить'),
        //     icon: Icon(Icons.camera),
        //   ),
        // ),
      ],
    );
  }
}
