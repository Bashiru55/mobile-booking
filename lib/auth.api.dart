import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> fetchUsers( {required staff_id, required password}) async {
  String url = "http://192.168.137.73/booking/tbl_users.php";

  final response = await http.post(Uri.parse(url), body: {

    "staff_id": staff_id,
    "password": password
  });
  return jsonDecode(response.body);
}

class staff_id {
}

Future<Map?> fetchSingleUsers({staff_id, password}) async {
  String url = "http://192.168.137.73/booking/tbl_users.php?staff_id=$staff_id&password=$password";
  final response = await http.get(Uri.parse(url),);
  // print(response.body);

  return jsonDecode(response.body);
}

//
// Future<http.Response> getEducationData(String staff_id)async{
//
// }