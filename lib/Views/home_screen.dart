import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:z_flix/Views/HollywoodMovies.dart';
import 'package:z_flix/Model/Movie.dart';
import 'package:z_flix/Views/bollywood_screen.dart';
import 'package:z_flix/controllers/home_controller.dart';
import 'package:z_flix/customListView.dart';
import 'package:z_flix/Views/detailMovie.dart';

class HomeScreen extends StatelessWidget {
  final List<String> moviePosters = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomeController controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      drawer: Drawer(
          backgroundColor: Colors.black54,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.3,
                child: DrawerHeader(
                    child: Center(
                  child: Icon(
                    FontAwesomeIcons.solidCircleUser,
                    size: screenHeight * 0.14,
                  ),
                )),
              ),
              InkWell(
                  onTap: () {
                    Get.to(HomeScreen());
                  },
                  child: const ListTile(
                      title: Text(
                    "Home",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.yellow,
                        fontWeight: FontWeight.w700),
                  ))),
              InkWell(
                  onTap: () {
                    Get.to(Hollywood());
                  },
                  child: const ListTile(
                      title: Text(
                    "Hollywood",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.yellow,
                        fontWeight: FontWeight.w700),
                  ))),
              InkWell(
                  onTap: () {
                    Get.to(Bollywood());
                  },
                  child: const ListTile(
                      title: Text(
                    "Bollywood",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.yellow,
                        fontWeight: FontWeight.w700),
                  ))),
            ],
          )),
      backgroundColor: Colors.black,
      body: Obx(() {

        if (controller.isLoading.value|| controller.trendingMovies.value.results!.isEmpty) {
          return SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.yellow,),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            scaffoldKey.currentState!.openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          )),
                      Text(
                        'Home',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        width: screenWidth*0.4,
                        height: screenHeight*0.05,
                        child: TextField(
                          controller: controller.searchQuery,
                          onChanged: (value) async {
                            if (value.trim().isEmpty || controller.searchQuery.text.toString().trim().isEmpty) {
                              controller.searchedMovies.value.results!.clear();
                              controller.update();
                            } else {
                              await controller.fetchBySearching(value);
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade400,
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth*0.05),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth*0.05),
                              borderSide:
                              const BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth*0.05),
                              borderSide:
                              const BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight*0.28,
                            width: screenWidth,
                            child: CarouselSlider(
                              items: controller.imageUrls
                                  .map((url) => ClipRRect(
                                      borderRadius: BorderRadius.circular(screenWidth*0.03),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w500/$url",
                                        fit: BoxFit.fill,
                                        width: screenWidth,
                                      )))
                                  .toList(),
                              options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                height: screenHeight*0.3,
                              ),
                            ),
                          ),
                           SizedBox(
                            height: screenHeight*0.0425,
                          ),
                          Text(
                            '  Top Rated Movies',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                           SizedBox(
                            height: screenHeight*0.01,
                          ),
                          controller.topRatedMovies.value.results!.isNotEmpty
                              ? CustomListView(
                                  resultType: controller
                                      .topRatedMovies.value.results!
                                      .toList())
                              : const SizedBox(),

                          SizedBox(height: screenHeight*0.042,),
                          Text(
                            '  Popular Movies',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight*0.01,
                          ),
                          controller.popularMovies.value.results!.isNotEmpty
                              ? CustomListView(
                                  resultType: controller
                                      .popularMovies.value.results!
                                      .toList())
                              : const SizedBox(),
                          SizedBox(height: screenHeight*0.042,),

                          Text(
                            '  Action Movies',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight*0.01,
                          ),
                          controller.actionMovies.value.results!.isNotEmpty
                              ? CustomListView(
                                  resultType: controller
                                      .actionMovies.value.results!
                                      .toList())
                              : const SizedBox(),
                          SizedBox(height: screenHeight*0.042,),

                          Text('  Comedy Movies',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                              )),
                          SizedBox(
                            height: screenHeight*0.01,
                          ),
                          controller.comedyMovies.value.results!.isNotEmpty
                              ? CustomListView(
                                  resultType: controller
                                      .comedyMovies.value.results!
                                      .toList())
                              : const SizedBox(),
                          SizedBox(height: screenHeight*0.042,),

                          Text('  Horror Movies',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                              )),
                          SizedBox(
                            height: screenHeight*0.01,
                          ),
                          controller.horrorMovies.value.results!.isNotEmpty
                              ? CustomListView(
                                  resultType: controller
                                      .horrorMovies.value.results!
                                      .toList())
                              : const SizedBox(),
                          SizedBox(height: screenHeight*0.042,),

                        ],
                      ),
                      controller.searchQuery.text
                                  .toString().trim()
                                  .isNotEmpty
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: screenWidth*0.6,
                                height: screenWidth*0.6,
                                color: Colors.white,
                                child: ListView.builder(
                                    itemCount: controller
                                        .searchedMovies.value.results!.length,
                                    itemBuilder: (context, index) {
                                      List<Results>? seachedMovies =
                                          controller.searchedMovies.value.results;
                                      return seachedMovies![index]
                                                  .posterPath !=
                                              null
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return MovieDetailScreen(
                                                      movieInfo:
                                                          seachedMovies[
                                                              index]);
                                                }));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: screenHeight*0.08,
                                                      width: screenWidth*0.08,
                                                      child: Image.network(
                                                          "https://image.tmdb.org/t/p/w500/${seachedMovies[index].posterPath}"),
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight*0.01,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "${seachedMovies[index].title}",
                                                        style:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 20),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const SizedBox();
                                    }),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }),

    );
  }
}
