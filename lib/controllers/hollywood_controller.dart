
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/Movie.dart';
import '../Services/api_Services.dart';

class HollywoodController extends GetxController {
  MovieModel? hollywoodMovies;
  Rx<int> pageNo = 1.obs;

  MovieModel? searchedMovies;
  TextEditingController searchQuery = TextEditingController();

  Rx<bool> isSearching = false.obs;



  ApiServices apiServices = ApiServices();

  searchMovies(String keyWord) async {
    isSearching.value = true;
  searchedMovies = await apiServices.fetchData(
      endPoint:
      "/3/search/movie?query=${keyWord
          .trim()}&language=en&with_original_language=en&include_adult=false&region=US");
  update();
  }

  fetchHollywood() async {
    hollywoodMovies = await apiServices.fetchData(
        endPoint:
            "/3/discover/movie?region=US&with_original_language=en&page=$pageNo");

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchHollywood();
  }
}
