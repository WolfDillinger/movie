import 'dart:convert';
import 'package:movie/model/movie.dart';
import '../helper/public_val.dart';
import 'package:http/http.dart' as http;

class MovieServices {
  String url = "https://api.themoviedb.org/3/discover/movie?";

  setAuthHeaders() => {
    'Accept': 'application/json',
    'Authorization': 'Bearer $tokenUser',
  };

  Future<List<MovieModel>> get([int page = 1]) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
          url +
              " include_adult=false&include_video=false&language=en-US&page=$page&sort_by=popularity.desc",
        ),
        headers: setAuthHeaders(),
      );

      List<MovieModel> lists = [];

      for (dynamic route in jsonDecode(res.body)["results"]) {
        lists.add(MovieModel.fromMap(route));
      }

      return lists;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<MovieModel>> search(String word, [int page = 1]) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/search/movie?query=$word&page=$page&language=en-US",
        ),
        headers: setAuthHeaders(),
      );

      List<MovieModel> lists = [];

      for (dynamic route in jsonDecode(res.body)["results"]) {
        lists.add(MovieModel.fromMap(route));
      }

      return lists;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<MovieModel>> favorite([int page = 1]) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/account/21823742/favorite/movies?language=en-US&page=$page&sort_by=created_at.asc",
        ),
        headers: setAuthHeaders(),
      );

      List<MovieModel> lists = [];

      for (dynamic route in jsonDecode(res.body)["results"]) {
        lists.add(MovieModel.fromMap(route));
      }

      return lists;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<MovieModel>> top([int page = 1]) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=$page",
        ),
        headers: setAuthHeaders(),
      );

      List<MovieModel> lists = [];

      for (dynamic route in jsonDecode(res.body)["results"]) {
        lists.add(MovieModel.fromMap(route));
      }

      return lists;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  addFav(int id, bool like) async {
    try {
      final val = {"media_type": "movie", "media_id": id, "favorite": like};

      http.Response res = await http.post(
        Uri.parse("https://api.themoviedb.org/3/account/21823742/favorite"),
        body: val,
        headers: setAuthHeaders(),
      );

      return jsonDecode(res.body)["success"];
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  addRate(int id, double value) async {
    try {
      final val = {"value": value};

      http.Response res = await http.post(
        Uri.parse("https://api.themoviedb.org/3/movie/$id/rating"),
        body: val,
        headers: setAuthHeaders(),
      );

      return jsonDecode(res.body)["success"];
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  deleteRate(int id) async {
    try {
      http.Response res = await http.delete(
        Uri.parse("https://api.themoviedb.org/3/movie/$id/ratin"),
        headers: setAuthHeaders(),
      );

      return jsonDecode(res.body)["success"];
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
