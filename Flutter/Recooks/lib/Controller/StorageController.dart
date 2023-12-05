import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './ClientController.dart';

class StorageController extends ClientController {
  Storage? storage;

  @override
  void onInit() {
    super.onInit();
    if (client != null) {
      storage = Storage(client!);
    }
  }

  Future<void> storeImage(File file) async {
    try {
      if (storage == null) {
        throw Exception("Storage is null");
      }

      final result = await storage!.createFile(
        bucketId: '6566a5056490a948b4bd',
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: file.path,
          filename: 'image.jpg',
        ),
      );
      print("StorageController:: storeImage $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Storage",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }

  Future<List<String>> listImages() async {
    try {
      if (storage == null) {
        throw Exception("Storage is null");
      }

      final result = await storage!.listFiles(
        bucketId: '6566a5056490a948b4bd',
      );
      List<String> imageUrls = [];
      for (var file in result.files) {
        String imageUrl = storage!.getFileView(
          bucketId: '6566a5056490a948b4bd',
          fileId: file.$id,
        ) as String;
        imageUrls.add(imageUrl);
      }
      return imageUrls;
    } catch (error) {
      Get.defaultDialog(
        title: "Error Storage",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
      return [];
    }
  }
}