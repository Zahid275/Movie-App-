import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:z_flix/Model/Movie.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "https://api.themoviedb.org";
  static String? apiKey = dotenv.env['API_KEY'];


  static Future<MovieModel> fetchData({required endPoint}) async {
    final url = Uri.parse("$baseUrl$endPoint");

    final response = await http.get(url, headers: {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json"
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      return MovieModel.fromJson(body);
    } else {
      print(response.body);
      return MovieModel.fromJson({});
    }
  }


}
