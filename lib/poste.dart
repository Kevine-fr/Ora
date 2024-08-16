import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ora/liste.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  File? _imageFile;
  final picker = ImagePicker();
  TextEditingController _commentController = TextEditingController();
  bool _imagePickerActive = false;
  bool _isUploading = false;
  String userId = FirebaseAuth.instance.currentUser!.uid;


  Future<void> _getImageFromGallery() async {
    if (_imagePickerActive) {
      print('Image picker is already active');
      return;
    }

    _imagePickerActive = true;

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    _imagePickerActive = false;

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      print('No image selected.');
      return;
    }

    setState(() {
      _isUploading = true; // Commence le chargement
    });

    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');
    UploadTask uploadTask = storageReference.putFile(_imageFile!);
    await uploadTask.whenComplete(() => print('Image uploaded'));
    String imageUrl = await storageReference.getDownloadURL();

    await FirebaseFirestore.instance.collection('posts').add({
      'image_url': imageUrl,
      'comment': _commentController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    await FirebaseFirestore.instance.collection('utilisateurs').doc(userId).collection('posts').doc().set({
      'image_url': imageUrl,
      'comment': _commentController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Liste(),
      ),
    );

    setState(() {
      _isUploading = false; // Termine le chargement
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Annuler',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue,
                    ),
                    child: TextButton(
                      onPressed: _isUploading ? null : _uploadImage,
                      child: Text(
                        'Poster',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.grey,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'image/kaiser.jpg',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: 'Ecrivez votre poste...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              filled: false,
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1),
                    _imageFile != null
                        ? Padding(
                            padding: const EdgeInsets.only(left: 52),
                            child: _isUploading
                                ? CircularProgressIndicator(
                                    color: Colors.blue,
                                  )
                                : Image.file(
                                    _imageFile!,
                                  ),
                          )
                        : Container(
                            height: 200,
                            color: Colors.black,
                            child: Center(),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        onPressed: _getImageFromGallery,
        child: Icon(
          Icons.image_search_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
