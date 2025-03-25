import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Model/Movie.dart';
import '../Services/api_Services.dart';

class BollywoodController extends GetxController {
  MovieModel? bollywoodMovies;
  Rx<int> pageNo = 1.obs;

  Rx<bool> isSearching = false.obs;

  MovieModel? searchedMovies;

  ApiServices apiServices = ApiServices();

  TextEditingController searchQuery = TextEditingController();

  searchMovies(String keyWord) async {
    isSearching.value = true;
    searchedMovies = await ApiServices.fetchData(
        endPoint:
            "/3/search/movie?query=${keyWord.trim()}&language=en&with_original_language=hi&include_adult=false&region=IN");
    update();
  }

  fetchBollywood() async {
    bollywoodMovies = await ApiServices.fetchData(
        endPoint:
            "/3/discover/movie?region=IN&with_original_language=hi&page=$pageNo}");

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBollywood();
  }
}
