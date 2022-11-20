import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class SearchPage extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    late SearchProvider provider;
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text("Search term must be longer"),
          )
        ],
      );
    } else {
      return ChangeNotifierProvider<SearchProvider>(
        create: (_) => SearchProvider(apiService: ApiService()).searchRestaurant(query),
        child: Scaffold(
          body: Consumer<SearchProvider>(
            builder: (context, state, _) {
              if (state.state == Result.loading) {
                return const Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.black26,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ));
              } else if (state.state == Result.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result?.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result?.restaurants[index];
                    return CardRestaurant(restaurants: restaurant!);
                  },
                );
              } else if (state.state == Result.noData) {
                return Center(child: Text(state.message));
              } else if (state.state == Result.error) {
                return const Center(
                  child: Text('Coba periksa koneksi anda'),
                );
              } else {
                return const Center(child: Text('No data to display'));
              }
            },
          ),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Cari Restoran"),
    );
  }
}