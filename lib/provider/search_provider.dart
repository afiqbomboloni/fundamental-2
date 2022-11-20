import 'package:restaurant_app/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum Result {loading, noData, hasData, error}


class SearchProvider extends ChangeNotifier{
  final ApiService apiService;

  SearchProvider({required this.apiService});

  SearchProvider searchRestaurant(String query) {
    _fetchRestaurant(query);
    return this;
  }
  RestaurantSearch? _restaurantSearch;
  Result? _state;
  String _message = '';
  String _query = "";

  String get message => _message;

  RestaurantSearch? get result => _restaurantSearch;

  Result? get state => _state;
  String get query => _query;

  Future<dynamic> _fetchRestaurant(String query) async {
    try {
      _state = Result.loading;
      notifyListeners();
      final response = await apiService.searchRestaurant(query);
      if (response.restaurants.isEmpty) {
        _state = Result.noData;
        notifyListeners();
        return _message = 'Tidak ada data yang dimaksud';
      } else {
        _state = Result.hasData;
        notifyListeners();
        return _restaurantSearch = response;
        
        // return response;
      }
    } catch (e) {
      _state = Result.error;
      notifyListeners();
      return _message = "Error sadayana";
    }
  }

}