import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:prak/Controller/ThemeNotifier.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = '';
  File? _image;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email ?? '';
      int atIndex = email.indexOf('@');
      setState(() {
        userName = email.substring(0, atIndex);
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      await uploadImageToAppwrite();
    }
  }

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      await uploadImageToAppwrite();
    }
  }

  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Dark Mode'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<ThemeNotifier>().enableDarkMode();
                },
              ),
              ListTile(
                title: Text('Light Mode'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<ThemeNotifier>().enableLightMode();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> uploadImageToAppwrite() async {
    const String projectID = '6566a4a234cbff8753b2';
    const String apiKey =
        'bd91bb88dfd03bf21223bee7c6d0c0ee8058e1019df04458c7f16d959dd3a718b3929907a6db428adf929cdc357d03f90ab90f5564a05ac869fc0f2fffd94f472d3f543606299bc7eefffc07ac26c97e93e88d0701fe6aa490f9c3647c951ad88d8d7bb1a8895e89c7828a3d631745a70926ccc5a63cd0c19badc1ec93091170';

    Client client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject(projectID);
        // .setSelfSigned(status: true);

    client.setJWT(apiKey);

    Databases databases = Databases(client);

    const String databaseID = '6566a53dbc21847ed260';
    const String collectionID = '6566a54583fece31de3f';

    try {
      var result = await databases.createDocument(
        databaseId: databaseID,
        documentId: ID.unique(),
        collectionId: collectionID,
        data: {
          'imagePath': '[pict]',
        },
      );
      print(result);
    } catch (e) {
      print('Error uploading image to Appwrite Database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeNotifier>().isDarkMode
          ? Color.fromARGB(66, 66, 66, 100)
          : Color.fromARGB(255, 248, 241, 241),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Profile',
          style: TextStyle(
            color: context.watch<ThemeNotifier>().isDarkMode
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: context.watch<ThemeNotifier>().isDarkMode
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              _showSettingsDialog();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _showImagePickerOptions();
              },
              child: Stack(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: _image == null
                        ? Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.white,
                          )
                        : CircleAvatar(
                            backgroundImage: Image.file(_image!).image,
                          ),
                  ),
                  if (_image != null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              userName,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: context.watch<ThemeNotifier>().isDarkMode
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}