
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState {loading, noData, hasData, error}


class RestaurantDetailProvider extends ChangeNotifier{
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService});

  RestaurantDetailProvider getDetailRestaurant(String id) {
    _fetchRestaurant(id);
    return this;
  }

  late RestaurantDetail _restaurantDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetail get result => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final response = await apiService.getDetailRestaurant(id);
      if (!response.error) {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = response;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "No data found";
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }


}