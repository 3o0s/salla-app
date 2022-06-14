class UserModel {
  final String? message;
  final bool status;
  final UserData? data;

  UserModel.fromjson(Map<String, dynamic> json)
      : message = json['message'],
        status = json['status'],
        data = json['data'] != null ? UserData.fromJson(json['data']) : null;
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String token;
  final String image;
  final int points;
  final int credit;

  UserData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        token = json['token'],
        image = json['image'],
        points = json['points'],
        credit = json['credit'];
}
