import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
// import 'package:restaurant_app/data/model/restaurant-detail.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatelessWidget {
  // static const routeName = '/restaurant_list';
  const RestaurantListPage({Key? key}) : super(key: key);

  Widget _buildList(context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator(
            backgroundColor: Colors.black26,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.black,
            ),
          ));
        } else if(state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurants: restaurant);
            },
          );
        } else if(state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if(state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text("Coba periksa koneksi Anda"),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text('Tidak ada data yang tampil'),
            ),
          );
        }
      },
    );
  }


  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchPage());
              
            
            },
          )
        ],
      ),
      body: _buildList(context)
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
      ),
      
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}