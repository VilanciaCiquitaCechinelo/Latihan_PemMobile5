import 'package:appwrite/appwrite.dart';
import 'package:cuaca/clientcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatabaseController extends ClientController {
  Databases? databases;
  @override
  void onInit() {
    super.onInit();
// appwrite
    databases = Databases(client);
  }
  Future storeUserName(Map map) async {
    try {
      final result = await databases!.createDocument(
        databaseId: "6567186a089cd9c6abe6",
        documentId: ID.unique(),
        collectionId: "656718768ed271435982",
        data: map,
        permissions: [
          Permission.read(Role.user("65670dbb96ee3d2a1d82")),
          Permission.update(Role.user("65670dbb96ee3d2a1d82")),
          Permission.delete(Role.user("65670dbb96ee3d2a1d82")),
        ],
      );
      print("DatabaseController:: storeUserName $databases");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
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
}