import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddWork extends StatefulWidget {
  @override
  _AddWorkState createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  File _image;
  final picker = ImagePicker();
  String name = '';

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink,
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
              child: TextField(
                controller: _title,
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
              child: TextField(
                controller: _description,
                decoration: InputDecoration(hintText: 'Description'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.grey[200],
                child: Center(
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(_image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(icon: Icon(Icons.add_a_photo), onPressed: getImage,iconSize: 40,),
            ),
            RaisedButton(
              color: Colors.white,
              child: Text('Post'),
              onPressed: () async {
                _title.clear();
                _description.clear();
                var profileImgURL;
                  var firebaseStorageRef =
                  FirebaseStorage.instance.ref().child("team");
                  if (_image != null) {
                    var eventImgRef = firebaseStorageRef.child(name);
                    StorageUploadTask imgUpload =
                        eventImgRef.putFile(_image);
                    StorageTaskSnapshot tempSnapshot =
                        await imgUpload.onComplete;
                    profileImgURL = await tempSnapshot.ref.getDownloadURL();
                  }
                  print(profileImgURL);
                FirebaseFirestore.instance.collection('posts').add({
                  'title': _title.text,
                  'description': _description.text,
                  'timestamp': Timestamp.now(),
                  'name': 'username'
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
