import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:z_flix/Model/Movie.dart';
import 'package:z_flix/Services/api_Services.dart';

class HomeController extends GetxController {
  final String baseUrl = "https://api.themoviedb.org/3/";
  final searchQuery = TextEditingController();
  final ApiServices apiService = ApiServices();



  Rx<int> pageNo = 1.obs;
  Rx<bool> isLoading = true.obs;
  RxList<String> imageUrls = <String>[].obs;
  Rx<MovieModel> trendingMovies = MovieModel().obs;
  Rx<MovieModel> topRatedMovies = MovieModel().obs;
  Rx<MovieModel> upComingMovies = MovieModel().obs;
  Rx<MovieModel> popularMovies = MovieModel().obs;
  Rx<MovieModel> searchedMovies = MovieModel().obs;
  Rx<MovieModel> actionMovies = MovieModel().obs;
  Rx<MovieModel> comedyMovies = MovieModel().obs;
  Rx<MovieModel> horrorMovies = MovieModel().obs;

  Future<void> fetchData() async {
    try {
      isLoading(true);

      // Fetching all APIs in parallel
      var results = await Future.wait([
        //For TendinG
        apiService.fetchData(endPoint: "/3/trending/movie/week"),
        //for toP Rated
        apiService.fetchData(endPoint: "/3/movie/top_rated"),
        //For Action Movies
        apiService.fetchData(
            endPoint: "/3/discover/movie?with_genres=28&page=1"),
        // For Popular movies
        apiService.fetchData(
            endPoint: "/3/movie/popular?language=en-US&page=1"),
        //foR Horror
        apiService.fetchData(
            endPoint: "/3/discover/movie?with_genres=27&page=1"),
        // For Comedy
        apiService.fetchData(
            endPoint: "/3/discover/movie?with_genres=35&page=1"),
      ]);

      // Assign results to Objects
      trendingMovies.value = results[0];
      topRatedMovies.value = results[1];
      actionMovies.value = results[2];
      popularMovies.value = results[3];
      horrorMovies.value = results[4];
      comedyMovies.value = results[5];

      imageUrls.assignAll(trendingMovies.value.results
              ?.map((e) => e.posterPath ?? "")
              .toList() ??
          []);
      isLoading(false);
    } catch(e){
      isLoading(true);


    }
  }

  Future<void> fetchBySearching(String movieTitle) async {
    searchedMovies.value = await apiService.fetchData(
        endPoint: "/3/search/movie?query=${movieTitle.trim()}");
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
}
