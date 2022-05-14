class HomeModel {
  final bool status;
  final HomeData data;
  HomeModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        data = HomeData.fromJson(json['data']);
}

class HomeData {
  List<BannerElemet> banners = [];
  List<Product> products = [];
  HomeData.fromJson(Map<String, dynamic> json) {
    for (Map<String, dynamic> item in json['banners']) {
      banners.add(BannerElemet.fromJson(item));
    }
    for (Map<String, dynamic> item in json['products']) {
      products.add(Product.fromJson(item));
    }
  }
}

class BannerElemet {
  final int id;
  final String image;
  BannerElemet.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'];
}

class Product {
  final int id;
  final dynamic oldPrice, discount, price;
  final String name, image;
  final bool inCart, inFavorites;

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        oldPrice = json['old_price'],
        discount = json['discount'],
        name = json['name'],
        image = json['image'],
        inFavorites = json['in_favorites'],
        inCart = json['in_cart'];
}
