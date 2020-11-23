import 'dart:io';
import 'package:dsc_projects/pages/posting.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dsc_projects/mainPage.dart';

TextStyle whiteRobotoText = GoogleFonts.roboto(color: Colors.white);
final TextEditingController _title = TextEditingController();
final TextEditingController _description = TextEditingController();
File _image;

class AddWork extends StatefulWidget {
  @override
  _AddWorkState createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
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
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                  controller: _title,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: whiteRobotoText,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                    ),
                  ),
                  style: whiteRobotoText),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                style: whiteRobotoText,
                controller: _description,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: whiteRobotoText,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: InkWell(
                child: Container(
                  // width: 200,
                  // height: 200,
                  color: Colors.blue,
                  child: Center(
                    child: _image == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 50.0,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text('Add Image',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        : Image.file(_image),
                  ),
                ),
                onTap: () => getImage(),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: RaisedButton(
              color: Colors.yellow[700],
              child: Text(
                'Post',
                style: GoogleFonts.roboto(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
              onPressed: () async {
                Navigator.push(context, createRoute());
                await postImage();
                setState(() {});
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

postImage() async {
  var name = _title.text;
  String images;
  if (_image != null) {
    try {
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref('uploads/$name')
          .putFile(_image);
      firebase_storage.TaskSnapshot snapshot = await task;
      images = await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e);
    }
  }
  print(images);
  await FirebaseFirestore.instance.collection('posts').add({
    'title': _title.text,
    'description': _description.text,
    'timestamp': Timestamp.now(),
    'name': firestore.name,
    'myImageURL': firestore.imageURL,
    'uid': firestore.uid,
    'email': firestore.email,
    'images': images,
  });
  _title.clear();
  _description.clear();
  _image = null;
}

Route createRoute() {
  CurvedAnimation curvedTransition;
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Posting(),
    transitionDuration: Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      curvedTransition =
          CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return ScaleTransition(
        scale: curvedTransition,
        child: child,
      );
    },
  );
}
