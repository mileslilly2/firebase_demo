import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

// upload_file.dart';


class UploadFile extends StatefulWidget {
  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class UploadFileScreen extends StatefulWidget {
  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  File? _image;
  String _message = '';

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future uploadImage() async {
    if (_image == null) {
      String fileName = path.basename(_image!.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref(fileName);
      setState(() {
        _message = 'Uploading file please wait';
      });
      ref.putFile(_image!).then((TaskSnapshot result) {
        if (result.state == TaskState.success) {
          setState(() {
            _message = 'File uploaded successfully';
          });
        } else {
          setState(() {
            _message = 'Error uploading file';
          });
        }
      });
      
    

    };

    final storageRef = FirebaseStorage.instance.ref();
    final fileRef = storageRef.child('images/${path.basename(_image!.path)}');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload File'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              child: const Text('Choose Image'),
              onPressed: () {
                getImage();
               } // Here is where you link the button to the function
            ),
            SizedBox(
              height: 200,
              child: _image == null ? Text('No image selected') : Image.file(_image!),
            ),
            ElevatedButton(
              child: const Text('Upload Image'),
              onPressed: () {
                // Implementation for uploading the image will go here
                uploadImage();
              },
            ),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
