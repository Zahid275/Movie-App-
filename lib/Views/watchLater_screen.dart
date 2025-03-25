import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_flix/Model/watch_later_model.dart';
import 'package:z_flix/Utils/customDrawer.dart';
import 'package:z_flix/controllers/watchLater_controller.dart';

import '../Utils/wacthLater_tile.dart';

class WatchLater_Screen extends StatelessWidget {
  WatchLater_Controller favController = WatchLater_Controller();

  WatchLater_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Watch Later Movies ",
          style: TextStyle(
              color: Theme.of(context).primaryColor, fontSize: 22, fontWeight: FontWeight.w700),
        ),
        actions: [
          Obx(
            () {
              return favController.selectedItems.isNotEmpty
                  ? Row(
                    children: [
                      Text("${favController.selectedItems.length}",style: const TextStyle(fontSize: 22,color: Colors.yellow),),
                      IconButton(
                          onPressed: () async {
                            await favController
                                .deleteFromWL(favController.selectedItems);
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  )
                  : const SizedBox(
                      width: 1,
                    );
            },
          )
        ],
      ),
      drawer:   CustomDrawer(),
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.02),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                    .collection("Fav")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: Colors.yellow);
                  }

                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.docs.isEmpty) {
                    return const Text("No Movies in Watch Laters",
                        style: TextStyle(color: Colors.yellow));
                  } else {
                    RxList<QueryDocumentSnapshot<Map<String, dynamic>>> data =
                        snapshot.data!.docs.obs;
                    return Stack(
                      children: [
                        ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: maxHeight * 0.015,
                                  ),
                                  child: Obx(() {
                                    WL_Model favModel = WL_Model(
                                        onLongPress: () {
                                          favController.longPressLogic(
                                              index: index, data: data);
                                        },
                                        color: favController.selectedItems
                                                .contains(data[index]["title"])
                                            ? Colors.blueGrey.shade200
                                            : Colors.yellow.shade200,
                                        onTap: () {
                                          favController.singleTapLogic(
                                              index: index, data: data);
                                        },
                                        movieData: data[index].data());

                                    return FavMovieTile(
                                      favModel: favModel,
                                    );
                                  }));
                            }),
                        Obx(() {
                          return favController.isDeleting.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.yellowAccent,
                                ))
                              : const SizedBox();
                        })
                      ],
                    );
                  }
                })),
      ),
    );
  }
}
