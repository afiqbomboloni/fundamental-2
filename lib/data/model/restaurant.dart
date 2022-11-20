

class RestaurantResult {
    RestaurantResult({
        required this.error,
        required this.message,
        required this.count,
        required this.restaurants,
    });

    bool error;
    String message;
    int count;
    List<Restaurant> restaurants;

    factory RestaurantResult.fromJson(Map<String, dynamic> json) => RestaurantResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from((json["restaurants"]).map((x) => Restaurant.fromJson(x)))
    );
}

class RestaurantDetail {
    RestaurantDetail({
        required this.error,
        required this.message,
        required this.restaurant,
    });

    bool error;
    String message;
    Restaurant restaurant;

    factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]));
}


class RestaurantSearch {
    RestaurantSearch({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    bool error;
    int founded;
    List<Restaurant> restaurants;

    factory RestaurantSearch.fromJson(Map<String, dynamic> json) => RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
    );
}


class Restaurant {
    Restaurant({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
        this.address,
        this.categories,
        this.menus,
        this.customerReviews,
    });

    String id;
    String name;
    String description;
    String pictureId;
    String city;
    double rating;
    String? address;
    List<Category>? categories;
    Menus? menus;
    List<CustomerReview>? customerReviews;

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        address: json["address"] == null ? null : json["address"],
        categories: json["categories"] == null
          ? null
          : List<Category>.from(json['categories'].map((x) => Category.fromJson(x))),
        menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
        customerReviews: json["customerReviews"] == null
          ? null
          : List<CustomerReview>.from((json["customerReviews"] as List)
              .map((x) => CustomerReview.fromJson(x))
              .where((review) => review.review != null && review.name.length > 0))
    );

}



class Category {
    Category({
        required this.name,
    });

    String name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
    );

}

class CustomerReview {
    CustomerReview({
        required this.name,
        required this.review,
        required this.date,
    });

    String name;
    String review;
    String date;

    factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
    );
}

class Menus {
    Menus({
        required this.foods,
        required this.drinks,
    });

    List<Category> foods;
    List<Category> drinks;

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
    );

}
