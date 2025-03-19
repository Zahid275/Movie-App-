import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_flix/Model/Movie.dart';
import 'package:z_flix/controllers/detail_screen_controller.dart';
import 'package:z_flix/controllers/home_controller.dart';

class MovieDetailScreen extends StatefulWidget {
  final Results? movieInfo;
  const MovieDetailScreen({super.key, required this.movieInfo});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final HomeController controller = HomeController();
  final DetailController detailController = Get.put(DetailController());

  @override
  void initState() {
    super.initState();
    detailController.getCast(widget.movieInfo!.id);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text('${widget.movieInfo!.title}'),
        backgroundColor: Colors.yellow,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                widget.movieInfo!.posterPath != null
                    ? Image.network(
                  'https://image.tmdb.org/t/p/w500/${widget.movieInfo!.posterPath}',
                  fit: BoxFit.fill,
                  width: screenWidth,
                  height: screenHeight * 0.6,
                )
                    : SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.6,
                  child: const Center(
                    child: Text(
                      "Image not available",
                      style: TextStyle(color: Colors.yellow, fontSize: 18),
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: Container(
                    padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.02, vertical: screenHeight*0.01),
                    color: Colors.red,
                    child: Text(
                      '${widget.movieInfo!.voteAverage}',
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
                    '${widget.movieInfo!.title}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.grey),
                      SizedBox(width: screenWidth * 0.01),
                      Text('${widget.movieInfo!.releaseDate}',
                          style: const TextStyle(color: Colors.grey)),
                      SizedBox(width: screenWidth * 0.04),
                      const Icon(Icons.language, color: Colors.grey),
                      SizedBox(width: screenWidth * 0.01),
                      Text('${widget.movieInfo!.originalLanguage}',
                          style: const TextStyle(color: Colors.grey)),
                      SizedBox(width: screenWidth * 0.04),
                      const Icon(Icons.movie, color: Colors.grey),
                      SizedBox(width: screenWidth * 0.01),
                      const Text("Action",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'About Movie',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '${widget.movieInfo!.overview}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'Cast',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  GetBuilder<DetailController>( // Rebuild when castInfo updates
                    builder: (controller) {
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: detailController.castInfo.length,
                          itemBuilder: (context, index) {
                            final castMember = controller.castInfo[index];
                            print(detailController.castInfo.length);
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        NetworkImage("https://image.tmdb.org/t/p/w500/${castMember["profile_path"]}"),

                                    backgroundColor: Colors.yellow,
                                  
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      castMember["original_name"],
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
