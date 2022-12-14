import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
// import 'package:restaurant_app/data/model/restaurant-detail.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/common/styles.dart';

import 'data/api/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
          ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
        textTheme: myTextTheme,
        appBarTheme: const AppBarTheme(elevation: 0),
      ),

      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName:(context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
        restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        
      ),

      },
    )
    );
      
    
  }

  
}
