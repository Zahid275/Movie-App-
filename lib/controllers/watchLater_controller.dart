import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/Movie.dart';
import '../Views/movie_detail_screen.dart';

class WatchLater_Controller extends GetxController {
  Rx<Color> bgColor = Colors.yellow.shade100.obs;

  RxSet<String> selectedItems = <String>{}.obs;

  Rx<bool> isDeleting = false.obs;

  deleteFromWL(Set data) async {
    isDeleting(true);
    try {
      for (int i = 0; i < selectedItems.length; i++) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Fav")
            .doc(selectedItems.toList()[i].toString())
            .delete();
      }
      selectedItems.clear();

      Get.showSnackbar(const GetSnackBar(
        messageText: Text(
          "Successfully deleted all selected items",
          style: TextStyle(color: Colors.yellow),
        ),
        duration: Duration(seconds: 3),
      ));
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        messageText: Text(
          "Error in deleting Fav Moviees $e",
          style: const TextStyle(color: Colors.yellow),
        ),
        duration: const Duration(seconds: 3),
      ));
    } finally {
      isDeleting(false);
    }
  }

  singleTapLogic({required int index, required  data}) {
    if (selectedItems.isNotEmpty &&
        !(selectedItems.contains(data[index]["title"]))) {
      selectedItems.add(data[index]["title"]);
    } else if (selectedItems.contains(data[index]["title"])) {
      selectedItems.remove(data[index]["title"]);
    } else {
      Get.to(MovieDetail(movieInfo: Results.fromJson(data[index].data())));
    }
  }

  longPressLogic({required int index,required data}){
    selectedItems
        .add(data[index]["title"]);

  }







}
