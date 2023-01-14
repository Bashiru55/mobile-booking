import 'package:mysql1/mysql1.dart';
class Mysql{
  static String host='localhost',
                user='root',
            password='',
                  db='booking';
  static int Port= 3306;
  Mysql();
  Future<MySqlConnection> getConnection()async{
    var settings = new ConnectionSettings(
      host: host,
      user: user,
      password: password,
      db: db
    );
    return await MySqlConnection.connect(settings);
  }
}