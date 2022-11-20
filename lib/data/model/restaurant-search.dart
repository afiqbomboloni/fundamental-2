

import 'dart:convert';

RestaurantSearch restaurantSearchFromJson(String str) => RestaurantSearch.fromJson(json.decode(str));

String restaurantSearchToJson(RestaurantSearch data) => json.encode(data.toJson());

class RestaurantSearch {
    RestaurantSearch({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    bool error;
    int founded;
    List<RestaurantFounded> restaurants;

    factory RestaurantSearch.fromJson(Map<String, dynamic> json) => RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantFounded>.from(json["restaurants"].map((x) => RestaurantFounded.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class RestaurantFounded {
    RestaurantFounded({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    dynamic id;
    String name;
    String description;
    String pictureId;
    String city;
    double rating;

    factory RestaurantFounded.fromJson(Map<String, dynamic> json) => RestaurantFounded(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
    };
}
