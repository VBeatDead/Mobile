import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prak/Controller/ThemeNotifier.dart';
import 'package:prak/Controller/StorageController.dart';
import 'package:prak/View/todo/todoList.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = '';
  File? _image;
  StorageController storageController =
      StorageController();

  @override
  void initState() {
    super.initState();
    // fetchUserName();
    storageController.onInit();
  }

  // Future<void> fetchUserName() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     String email = user.email ?? '';
  //     int atIndex = email.indexOf('@');
  //     setState(() {
  //       userName = email.substring(0, atIndex);
  //     });
  //   }
  // }

  // Function to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
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

  Future<void> uploadProfileImage() async {
    try {
      await storageController.storeImage(_image!);
    } catch (error) {
      print("Error uploading image: $error");
    }
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
          IconButton(
            icon: Icon(
              Icons.edit_document,
              color: context.watch<ThemeNotifier>().isDarkMode
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoList(),
                ),
              );
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
                      child: GestureDetector(
                        onTap: () {
                          _showImagePickerOptions();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _image != null ? uploadProfileImage : null,
              child: Text('Upload Image'),
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