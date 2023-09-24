class LoginModel {
  final bool status;
  final String message;
  final UserData? data;

  LoginModel({required this.status, required this.message, required this.data});

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
        status: map['status'],
        message: map['message'],
        data: map['data'] != null ? UserData.fromMap(map['data']) : null);
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final int points;
  final int credit;
  final String token;

  UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.image,
      required this.points,
      required this.credit,
      required this.token});

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        phone: map['phone'],
        image: map['image'],
        points: map['points'],
        credit: map['credit'],
        token: map['token']);
  }
}
