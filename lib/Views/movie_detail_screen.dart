import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_flix/Model/Movie.dart';
import 'package:z_flix/controllers/detail_screen_controller.dart';

class MovieDetail extends StatelessWidget {
  final Results? movieInfo;

  MovieDetail({super.key, required this.movieInfo});

  final DetailController detailController = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text('${movieInfo!.title}'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                movieInfo!.posterPath != null
                    ? Image.network(
                  'https://image.tmdb.org/t/p/w500/${movieInfo!.posterPath}',
                  fit: BoxFit.fill,
                  width: screenWidth,
                  height: screenHeight * 0.6,
                )
                    : SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.6,
                  child: Center(
                    child: Text(
                      "Image not available",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18),
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                        vertical: screenHeight * 0.01),
                    color: Colors.red,
                    child: Text(
                      '${movieInfo!.voteAverage}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${movieInfo!.title}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.grey),
                      SizedBox(width: screenWidth * 0.01),
                      Text('${movieInfo!.releaseDate}',
                          style: const TextStyle(color: Colors.grey)),
                      SizedBox(width: screenWidth * 0.04),
                      const Icon(Icons.language, color: Colors.grey),
                      SizedBox(width: screenWidth * 0.01),
                      Text('${movieInfo!.originalLanguage}',
                          style: const TextStyle(color: Colors.grey)),
                      SizedBox(width: screenWidth * 0.04),
                      const Icon(Icons.movie, color: Colors.grey),
                      SizedBox(width: screenWidth * 0.01),
                      Expanded(
                        child: Text(
                          detailController.getGenre(movieInfo!.genreIds).join(', '),
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'About Movie',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton
                        (

                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow
                              ,shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12),)),
                          onPressed: ()async{
                        FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection("Fav").doc(movieInfo!.title).set(movieInfo!.toJson()).then((value){
                        Get.showSnackbar(GetSnackBar(messageText: Flexible(child: Text("${movieInfo!.title} was added to Watch Later",style: const TextStyle(color: Colors.yellow),)),duration: const Duration(seconds: 3),));
                        });

                      }, child: const Text("Add to Watch Later",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),))
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '${movieInfo!.overview}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: screenHeight * 0.03),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
