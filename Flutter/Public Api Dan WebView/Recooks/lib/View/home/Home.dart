import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prak/Model/DatabaseHelper.dart';
import 'package:prak/View/home/dashboard.dart';
import 'package:prak/View/profile/profile.dart';
import 'package:prak/Controller/Api.dart';
import 'package:prak/View/bookmark/bookmark.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _imagePickerController = ImagePicker();
  final _title = ''.obs;
  final _description = ''.obs;
  final _minutes = 0.obs;
  final _difficulty = ''.obs;

  int currentTab = 0;

  final List<Widget> screens = [
    Dashboard(),
    Setting(),
    Profile(),
    Bookmark(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _imagePickerController.pickImage(source: source);
    if (image != null) {

      Get.defaultDialog(
        title: 'Tambahkan Judul, Deskripsi, Menit, dan Kesulitan',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                _title.value = value;
              },
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              onChanged: (value) {
                _description.value = value;
              },
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            TextField(
              onChanged: (value) {
                _minutes.value = int.tryParse(value) ?? 0;
              },
              decoration: InputDecoration(labelText: 'Menit'),
            ),
            TextField(
              onChanged: (value) {
                _difficulty.value = value;
              },
              decoration: InputDecoration(labelText: 'Kesulitan'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              final data = {
                'imagePath': image.path,
                'title': _title.value,
                'description': _description.value,
                'minutes': _minutes.value,
                'difficulty': _difficulty.value,
              };
              DatabaseHelper().insertImageData(data).then((result) {
                if (result > 0) {
                  Get.snackbar(
                    'Sukses',
                    'Data berhasil diunggah!',
                    colorText: Colors.white,
                    backgroundColor: Colors.orange,
                    duration: Duration(seconds: 2),
                  );
                  Get.offAll(() => Home());
                } else {
                  Get.snackbar(
                    'Gagal',
                    'Gagal mengunggah data!',
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  );
                }
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
            ),
            child: Text('Upload'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Use SystemNavigator.pop() to exit the app immediately
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.add),
          onPressed: () {
            Get.defaultDialog(
              title: 'Pilih Sumber Gambar',
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                    ),
                    child: Text('Dari Galeri'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                    ),
                    child: Text('Dari Kamera'),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Dashboard();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: currentTab == 0 ? Colors.orange : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Bookmark();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark,
                            color: currentTab == 1 ? Colors.orange : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Setting();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.api_sharp,
                            color: currentTab == 2 ? Colors.orange : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Profile();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: currentTab == 3 ? Colors.orange : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}