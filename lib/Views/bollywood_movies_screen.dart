import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_flix/Model/Movie.dart';
import 'package:z_flix/controllers/bollywood_controller.dart';
import 'package:z_flix/Views/movie_detail_screen.dart';
import '../Utils/customDrawer.dart';

class Bollywood extends StatelessWidget {
  final controller = Get.put(BollywoodController());

  Bollywood({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      drawer:   CustomDrawer(),

      backgroundColor: Colors.black87,
      appBar: AppBar(
          backgroundColor: Colors.black87,
          title:  Text(
            "Bollywood Movies",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              TextField(
                controller: controller.searchQuery,
                onChanged: (value) {
                  if (value.isEmpty ||
                      controller.searchQuery.text.toString().isEmpty) {
                    controller.isSearching.value = false;
                    controller.update();
                  } else {
                    controller.searchMovies(value.toString());
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                ),
              ),
              GetBuilder<BollywoodController>(builder: (controller) {
                if (controller.bollywoodMovies == null ||
                    controller.bollywoodMovies!.results == null ||
                    controller.bollywoodMovies!.results!.isEmpty) {
                  return SizedBox(
                    height: screenHeight,
                    width: screenWidth,
                    child:  Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                } else {
                  return Column(children: [
                    controller.isSearching == false
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02,
                                vertical: screenHeight * 0.02),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount:
                                controller.bollywoodMovies!.results!.length,
                            itemBuilder: (context, index) {
                              List<Results>? bm =
                                  controller.bollywoodMovies!.results;

                              if (bm![index].posterPath != null) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(MovieDetail(
                                      movieInfo: bm[index],
                                    ));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://image.tmdb.org/t/p/w500/${bm[index].posterPath}")))),
                                );
                              } else {
                                return InkWell(
                                    onTap: () {
                                      Get.to(MovieDetail(
                                        movieInfo: bm[index],
                                      ));
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                "${controller.bollywoodMovies!.results![index].title}",
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            const Text(
                                              "NO IMAGE IN DB",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              }
                            })
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02,
                                vertical: screenHeight * 0.02),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount:
                                controller.searchedMovies!.results!.length,
                            itemBuilder: (context, index) {
                              if (controller.searchQuery.text
                                      .toString()
                                      .isNotEmpty &&
                                  controller
                                      .searchedMovies!.results!.isNotEmpty &&
                                  controller.searchedMovies != null &&
                                  controller.searchedMovies!.results![index]
                                          .posterPath !=
                                      null) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(MovieDetail(
                                      movieInfo: controller
                                          .searchedMovies!.results![index],
                                    ));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://image.tmdb.org/t/p/w500/${controller.searchedMovies!.results![index].posterPath}")))),
                                );
                              } else {
                                return null;
                              }
                            }),
                    controller.isSearching == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: const Icon(
                                    Icons.arrow_circle_left,
                                    size: 33,
                                  ),
                                  onPressed: () {
                                    if (controller.pageNo.value > 1) {
                                      controller.pageNo.value--;
                                      controller.fetchBollywood();
                                    }
                                  }),
                              Text(
                                "${controller.pageNo.value}",
                                style:  TextStyle(
                                    color: Theme.of(context).primaryColor, fontSize: 23),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_circle_right_rounded,
                                  size: 33,
                                ),
                                onPressed: () {
                                  controller.pageNo.value++;
                                  controller.fetchBollywood();
                                },
                              )
                            ],
                          )
                        : const SizedBox()
                  ]);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
