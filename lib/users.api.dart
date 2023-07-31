import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> tbluser(id) async {
  final response = await http.get(Uri.parse("http://10.5.0.86/bookings/tbl_users.php?"));
  var output = jsonDecode(response.body);

  return output;
}
