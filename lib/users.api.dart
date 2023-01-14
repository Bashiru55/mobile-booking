import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Map> fetchUsers(id) async {
  String url = "http://192.168.101.249/booking/tbl_users.php?";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data;
}


Future<dynamic> fetchbooking(id) async {
  String url = "http://10.42.0.103/booking/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_education'];
}

Future<dynamic> fetchUserSpouse(id) async {
  String url = "http://10.42.0.103/E-Humanis/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_spouse'];
}

Future<dynamic> fetchUserChildren(id) async {
  String url = "http://10.42.0.103/E-Humanis/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_children'];
}

Future<dynamic> fetchUserNextofkin(id) async {
  String url = "http://10.42.0.103/E-Humanis/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_nextofkin'];
}



Future<dynamic> fetchUserBeneficiaries(id) async {
  String url = "http://10.42.0.103/E-Humanis/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_beneficiaries'];
}


Future<dynamic> fetchUserParent(id) async {
  String url = "http://10.42.0.103/E-Humanis/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_parent'];
}


Future<dynamic> fetchUserTraining(id) async {
  String url = "http://10.42.0.103/E-Humanis/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_training'];
}


Future<dynamic> fetchUserDisciplinary(id) async {
  String url = "http://10.42.0.103/E-Humanis/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_misconduct'];

}


Future<dynamic> fetchUserTransfer(id) async {
  String url = "http://10.42.0.103/E-Humanis/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_transfer'];
}


Future<dynamic> fetchUserAccident(id) async {
  String url = "http://10.42.0.103/E-Humanis/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_accident'];
}


Future<dynamic> fetchUserIdentification(id) async {
  String url = "http://10.42.0.103/E-Humanis/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_identification'];
}


Future<dynamic> fetchUserPromotion(id) async {
  String url = "http://10.42.0.103/E-Humanis/users.php?id=$id";
  final response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  return data['data']['extra_promotion'];
}