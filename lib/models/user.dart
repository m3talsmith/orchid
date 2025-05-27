import '../storage/users.dart';
import '../storage/security.dart';

class User {
  String? id;

  User({this.id});

  static Future<User> create({
    required String salt,
    required String password,
  }) async {
    final id = await Security.generateId(salt: salt, password: password);
    final user = User(id: id);
    await UsersStorage.addUser(user.id!);
    return user;
  }

  Future<void> delete() async {
    await UsersStorage.removeUser(id!);
  }

  static Future<List<User>> list() async {
    final users = await UsersStorage.getUsers();
    return users.map((e) => User(id: e)).toList();
  }

  static Future<User?> login({
    required String salt,
    required String password,
  }) async {
    final id = await Security.generateId(salt: salt, password: password);
    final users = await UsersStorage.getUsers();
    for (final user in users) {
      if (user == id) {
        return User(id: id);
      }
    }
    await UsersStorage.addUser(id);
    return User(id: id);
  }
}
