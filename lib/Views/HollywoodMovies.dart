import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:z_flix/Model/Movie.dart';
import 'package:z_flix/controllers/hollywood_controller.dart';
import 'package:z_flix/Views/detailMovie.dart';

class Hollywood extends StatelessWidget {
  final controller = Get.put(HollywoodController());

  Hollywood({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text(
            "Hollywood Movies",
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03, vertical: screenHeight * 0.01),
          child: Column(
            children: [
              TextField(
                controller: controller.searchQuery,
                onChanged: (value) {
                  if (value.isEmpty ||
                      controller.searchQuery.text.toString().isEmpty) {
                    controller.isSearching.value = false;
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
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              GetBuilder<HollywoodController>(builder: (controller) {
                if (controller.hollywoodMovies == null ||
                    controller.hollywoodMovies!.results == null ||
                    controller.hollywoodMovies!.results!.isEmpty) {
                  return SizedBox(
                    height: screenHeight,
                    width: screenWidth,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
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
                                controller.hollywoodMovies!.results!.length,
                            itemBuilder: (context, index) {
                              List<Results>? hm =
                                  controller.hollywoodMovies!.results;

                              if (hm![index].posterPath != null) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(MovieDetailScreen(
                                      movieInfo: hm[index],
                                    ));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://image.tmdb.org/t/p/w500/${hm[index].posterPath}")))),
                                );
                              } else {
                                return InkWell(
                                    onTap: () {
                                      Get.to(MovieDetailScreen(
                                        movieInfo: hm[index],
                                      ));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            "${controller.hollywoodMovies!.results![index].title}",
                                            style: TextStyle(
                                                color: Colors.yellow,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Text(
                                          "NO IMAGE IN DB",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
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
                                  controller.searchedMovies != null) {
                                return Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://image.tmdb.org/t/p/w500/"
                                                "${controller.searchedMovies!.results![index].posterPath}"))),
                                  ),
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
                                      controller.fetchHollywood();
                                    }
                                  }),
                              Text(
                                "${controller.pageNo.value}",
                                style: const TextStyle(
                                    color: Colors.yellow, fontSize: 23),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_circle_right_rounded,
                                  size: 33,
                                ),
                                onPressed: () {
                                  controller.pageNo.value++;
                                  controller.fetchHollywood();
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
