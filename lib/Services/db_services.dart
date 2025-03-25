import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DbServices {
  static addTofavourites(
      {required Map<String, dynamic> movie, required userId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId.toString())
          .collection("Fav")
          .doc(movie["title"])
          .set(movie);
      print("Successfully added to favourites");
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          "Failed to add to Favourites $e",
          style: const TextStyle(color: Colors.yellow),
        ),
        duration: const Duration(seconds: 3),
      ));
    }
  }

  static createUser({required userId, required email,required name}) async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc("$userId").set({
        "name": "$name",
        "email": "$email",
      });
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          "Failed to Create user $e",
          style: const TextStyle(color: Colors.yellow),
        ),
        duration: const Duration(seconds: 3),
      ));
    }
  }
}
