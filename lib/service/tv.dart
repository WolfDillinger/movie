import 'dart:convert';
import 'package:movie/model/tv.dart';

import '../helper/public_val.dart';
import 'package:http/http.dart' as http;

class TvServices {
  String url = "https://api.themoviedb.org/3/discover/tv?";

  setAuthHeaders() => {
    'Accept': 'application/json',
    'Authorization': 'Bearer $tokenUser',
  };

  Future<List<TvModel>> get([int page = 1]) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
          url +
              " include_adult=false&include_video=false&language=en-US&page=$page&sort_by=popularity.desc",
        ),
        headers: setAuthHeaders(),
      );

      List<TvModel> lists = [];

      for (dynamic route in jsonDecode(res.body)["results"]) {
        lists.add(TvModel.fromMap(route));
      }

      return lists;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
