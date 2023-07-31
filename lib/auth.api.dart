import 'dart:convert';
import 'package:booking2/auth.dart';
import 'package:http/http.dart' as http;

Future<List> tblusers ( {required staff_id, required password}) async {
  String url = "http://192.168.103.249/booking/tbl_users.php";

  final response = await http.post(Uri.parse(url), body: {
    "staff_id": staff_id,
    "password": password,
  });
  return authFromJson(response.body);
}

