import 'dart:io';
import 'package:dsc_projects/main.dart';
import 'package:dsc_projects/pages/posting.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 25);

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
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                child: Text(
                  'Add New Post',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: TextField(
                  cursorColor: Colors.white,
                  controller: _title,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 15),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                    controller: _description,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 20.0),
                child: InkWell(
                  child: Card(
                    color: Colors.blue,
                    child: Container(
                      height: 250,
                      width: 250,
                      child: _image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.images,
                                  color: Colors.white,
                                  size: 50.0,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text('Add Image',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600))
                              ],
                            )
                          : Image.file(_image),
                    ),
                  ),
                  onTap: () => getImage(),
                ),
              ),
              Container(
                height: 40,
                child: RaisedButton(
                  color: Colors.black,
                  child: Text(
                    'Post',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  onPressed: () async {
                    Navigator.push(context, createRoute());
                    await postImage();
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
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
  await store.collection('posts').add({
    'title': _title.text,
    'description': _description.text,
    'timestamp': "Timestamp.now()", //CHECK LATER
    'name': myFirestore.name,
    'myImageURL': myFirestore.imageURL,
    'uid': myFirestore.uid,
    'email': myFirestore.email,
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
