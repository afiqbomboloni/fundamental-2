import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:restaurant_app/data/model/restaurant.dart';
// import 'package:restaurant_app/data/model/restaurantt.dart';
// import 'package:restaurant_app/data/model/restaurant-detail.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String baseUrlImage = "${_baseUrl}images/";
  static const String _url = "https://restaurant-api.dicoding.dev/search?q=";

  Future<RestaurantResult> getRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal menampilkan daftar restaurant');
    }
  }

  Future<RestaurantDetail> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("https://restaurant-api.dicoding.dev/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Ciee..gagal menampilkan detail restaurant');
    }
  }

  Future<RestaurantSearch> searchRestaurant(String? query) async {

    try {
      final response = await http.get(Uri.parse(_url + query!));
      if (response.statusCode == 200) {
        return RestaurantSearch.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed get data");
      }
    } catch (e) {
      throw Exception("error");
    }
  }

  // Future<RestaurantSearch> searchRestaurant({String query = ""}) async {
  //   try {
  //     final response = await http.get(Uri.parse("https://restaurant-api.dicoding.dev/search?q=query"));
  //     if (response.statusCode == 200) {
  //       return RestaurantSearch.fromJson(json.decode(response.body));
  //     } else {
  //       throw Exception("Failed get data");
  //     }
  //   } catch (e) {
  //     throw Exception("error");
  //   }
  // }
}