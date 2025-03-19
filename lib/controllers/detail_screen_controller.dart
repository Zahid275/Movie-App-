import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailController extends GetxController {
  RxList<Map> castInfo = <Map<String, dynamic>>[].obs;
  String baseUrl = "https://api.themoviedb.org/3/";
  String apiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1N2JmNTg3MTEzNTY2MDkzODUxNjA2NTIyN2ZlNTc2NSIsIm5iZiI6MTc0MTkxNTE3MS42ODUsInN1YiI6IjY3ZDM4NDIzZGNiYTcwYTI2OTY0ZTJlNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OOxd2-VtbEITdorqnqkmT_o7HPx2hcQe0Gb4xtlFvNs";

  getCast(id) async {
    final uri = Uri.parse(baseUrl+ "movie/$id/credits");

    final response = await http.get(uri, headers: {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json"
    });

    if (response.statusCode == 200) {
      castInfo.clear();
      final body = jsonDecode(response.body);
      for (int i = 0; i < body["cast"].length; i++) {
        castInfo.add(body["cast"][i]);
      }
      print(castInfo);
      update();
    } else {
      print("Failed to fetch cast: ${response.statusCode}");
    }
  }
}
