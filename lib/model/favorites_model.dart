import 'dart:convert';

class FavoritesModel {
  final bool status;
  final FavoritesData data;
  FavoritesModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = FavoritesData.fromJson(
          json['data'],
        );
}

class FavoritesData {
  List<Product> products = [];
  FavoritesData.fromJson(Map<String, dynamic> json) {
    for (Map<String, dynamic> item in json['data']) {
      products.add(Product.fromJson(item['product']));
    }
  }
}

class Product {
  final int id;
  final dynamic oldPrice, discount, price;
  final String name, image, description;

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        oldPrice = json['old_price'],
        discount = json['discount'],
        name = json['name'],
        image = json['image'],
        description = json['description'];
}
