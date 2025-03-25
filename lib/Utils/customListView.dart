import 'package:flutter/material.dart';
import 'package:z_flix/Model/Movie.dart';

import '../Views/movie_detail_screen.dart';
class CustomListView extends StatelessWidget {
  List<Results> resultType;

  CustomListView({super.key, required this.resultType});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return
      SizedBox(
        height:screenHeight*0.23,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: resultType.length,
          itemBuilder: (context, index) {
            return resultType[index].posterPath != null ?InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetail(movieInfo: resultType[index]),
                  ),
                );
              },
              child: Container(
                width: screenWidth*0.33 ,
                margin:  EdgeInsets.symmetric(horizontal: screenWidth*0.03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth*0.028),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://image.tmdb.org/t/p/w500/${resultType[index].posterPath}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ):const SizedBox();
          },
        ),

    );
  }
}
