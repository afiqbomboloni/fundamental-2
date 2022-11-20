
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/detail_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
 
  final Restaurant restaurant;
  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    late RestaurantDetailProvider provider;
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) {
        provider = RestaurantDetailProvider(apiService: ApiService());
        return provider.getDetailRestaurant(restaurant.id);
      },
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if(state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator(
                backgroundColor: Colors.black26,
                valueColor: AlwaysStoppedAnimation<Color>(
              Colors.black,
            ),
              ));
            } else if(state.state == ResultState.hasData) {
              return detail(context, state.result.restaurant, provider);
            } else if(state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if(state.state == ResultState.error) {
              return const Center(child: Text("Coba periksa koneksi Anda"));
            } else {
              return const Center(child: Text('No data to display'));
            }
          },
        ),
      ),
    );
  }
  detail(BuildContext context, Restaurant restaurants, RestaurantDetailProvider provider) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: const BoxDecoration(
              color: Colors.black26
            ),
            height: 400,
            child: Image.network('https://restaurant-api.dicoding.dev/images/medium/${restaurants.pictureId}', fit: BoxFit.cover)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0,bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16.0),
                  child: Text(
                    restaurants.name,
                    style: const TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 16.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        restaurants.city,
                        style: const TextStyle(color: Colors.white, fontSize: 13.0),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.star,
                                      color: Colors.purple,
                                    ),
                                    Text(restaurants.rating.toString()),
                                  ],
                                ),
                                Text.rich(TextSpan(children: [
                                  const WidgetSpan(
                                    child: Icon(Icons.location_on, size: 16.0, color: Colors.grey,)
                                  ),
                                  TextSpan(
                                    text: restaurants.city
                                  )
                                ]), style: const TextStyle(color: Colors.grey, fontSize: 12.0),)
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text("Rp 200k".toString(), style: const TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                              ),),
                             const  Text("/per duduk",style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey
                              ),)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          backgroundColor: Colors.purple,
                          // textColor: Colors.white,
                          ),
                          child: const Text("Pesan Sekarang", style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Text("Description".toUpperCase(), style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0
                      ),),
                      const SizedBox(height: 10.0),
                      Text(
                          restaurants.description, textAlign: TextAlign.justify,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis, style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0
                          ),),
                      const SizedBox(height: 10.0),
                      SizedBox(
                          height: 30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              const Text(
                                'Daftar Makanan: ',
                                style: TextStyle(color: Colors.black, fontSize: 20),
                              ),
                              Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5.0,
                                      horizontal: 16.0,
                                    ),

                                    decoration: BoxDecoration(
                                        color: Colors.red[300],
                                        borderRadius: BorderRadius.circular(20.0)),
                                    child: Row(
                                      children: 
                                      restaurants.menus?.foods.map((food) => Text(food.name, 
                                      style: const TextStyle(color: Colors.white, fontSize: 15.0),)).toList() ?? [],
                                  ),
                                    
                                  ),
                              
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 30,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              const Text(
                                'Daftar Minuman: ',
                                style: TextStyle(color: Colors.black, fontSize: 20),
                              ),
                              Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5.0,
                                      horizontal: 16.0,
                                    ),

                                    decoration: BoxDecoration(
                                        color: Colors.green[200],
                                        borderRadius: BorderRadius.circular(20.0)),
                                    child: Row(
                                      children: 
                                      restaurants.menus?.drinks.map((drink) => Text(drink.name, 
                                      style: const TextStyle(color: Colors.black, fontSize: 15.0),)).toList() ?? [],
                                  ),
                                    
                                  ),
                              
                            ],
                          ),
                        ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text("Details Page",style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}