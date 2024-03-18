import 'package:mysql1/mysql1.dart';
import 'package:mysql_app/model/user_model.dart';

class Mysql {

  Mysql();

   Future<MySqlConnection> getConnection() async {
    var settings =  ConnectionSettings(
    host: 'localhost', 
    port: 3306,
    user: 'root',
    password: '12345',
    db: 'flutter_mysql'
  );
    return await MySqlConnection.connect(settings);
  }
  
  Future<void> closeConnection(MySqlConnection connection) async {
    await connection.close();
  }

  Future<void> insert({required UserModel user}) async {
    MySqlConnection connection = await getConnection();
    await connection.query(
      'INSERT INTO users (id, name, email, password) VALUES (?, ?, ?, ?)',
      [user.name, user.email]
    );
    // await closeConnection(connection);
  }

  Future<List<UserModel>> getAllUsers() async {
    MySqlConnection connection = await getConnection();
    var results = await connection.query('SELECT * FROM users');
    return results.map((e) => UserModel.fromJson(e.fields)).toList();
  }

  Future<UserModel> getUserById({required int id}) async {
    MySqlConnection connection = await getConnection();
    var results = await connection.query('SELECT * FROM users WHERE id = ?', [id]);
    return UserModel.fromJson(results.first.fields);
  }

  Future<void> updateUser({required UserModel user}) async {
    MySqlConnection connection = await getConnection();
    await connection.query(
      'UPDATE users SET name = ?, email = ?, password = ? WHERE id = ?',
      [user.name, user.email, user.id]
    );
    await closeConnection(connection);
  }

  Future<void> deleteUser({required int id}) async {
    MySqlConnection connection = await getConnection();
    await connection.query('DELETE FROM users WHERE id = ?', [id]);
    await closeConnection(connection);
  }

}