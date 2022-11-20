import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurants;


  const CardRestaurant({required this.restaurants});


  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
        child: ListTile(
        contentPadding: 
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurants.pictureId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
                'https://restaurant-api.dicoding.dev/images/small/${restaurants.pictureId}',
                width: 100.0,
            ),
          ),
        ),
        title: Text(restaurants.name), 
          subtitle: Row(
            children: <Widget>[
              const Icon(Icons.location_on, color: Colors.blue, size: 15),
              Text(restaurants.city),
            ],
          ),
          onTap: () => Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: restaurants
        ),
      //     
      ),
    );
  }
}