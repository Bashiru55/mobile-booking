class Auth {
  int staff_id;
  String password;

  Auth({required this.staff_id, required this.password });

  factory Auth.fromJson(Map<String, dynamic> json){
    return Auth(
      staff_id: json['staff_id'] as int,
      password: json['password'] as String,
    );
  }
}