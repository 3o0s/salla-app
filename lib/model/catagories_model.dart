class CategoriesModel {
  final bool status;
  final CategoriesData categoriesData;
  CategoriesModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        categoriesData = CategoriesData.formJson(json['data']);
}

class CategoriesData {
  final int currentPage;
  List<Category> data = [];
  CategoriesData.formJson(Map<String, dynamic> json)
      : currentPage = json['current_page'] {
    for (Map<String, dynamic> e in json['data']) {
      data.add(Category.fromJson(e));
    }
  }
}

class Category {
  final String name;
  final int id;
  final String image;
  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'];
}
