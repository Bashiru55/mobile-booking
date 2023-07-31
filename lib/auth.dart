import 'dart:convert';

class Auth {
  int staff_id;
  String password;

  Auth({required this.staff_id, required this.password});

  factory Auth.fromJson(Map<String, dynamic> json){
    return Auth(
      staff_id: json['staff_id'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "staff_id": staff_id,
      "password": password,
    };
  }

  @override
  String toString() {
    return 'Auth: {staff_id:$staff_id,password:$password}';
  }
}

List<Auth> authFromJson(String strJson){
  final str = json.decode(strJson);
  return List <Auth>.from(str.map((data){
    return Auth.fromJson(data);
  }));
  }

  String AuthToJson(Auth data){
  final dyn = data.toJson();
  return json.encode(dyn);

}