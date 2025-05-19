import 'package:path_provider/path_provider.dart';
import 'dart:io';

enum UsersStorageKey { users }

class UsersStorage {
  static List<String> _users = [];

  static Future<List<String>> getUsers() async {
    final appdir = await getApplicationSupportDirectory();
    final usersdir = Directory('${appdir.path}/users');
    if (!usersdir.existsSync()) {
      usersdir.createSync(recursive: true);
    }
    _users = usersdir.listSync().map((e) => e.path.split('/').last).toList();
    return _users;
  }

  static Future<void> _createUser(String id) async {
    final appdir = await getApplicationSupportDirectory();
    final usersdir = Directory('${appdir.path}/users');
    if (!usersdir.existsSync()) {
      usersdir.createSync(recursive: true);
    }
    final userPath = '${usersdir.path}/$id';
    final userfile = File(userPath);
    if (userfile.existsSync()) {
      return;
    }
    userfile.createSync(recursive: true);
    userfile.writeAsStringSync(id);
  }

  static Future<void> addUser(String user) async {
    if (_users.contains(user)) {
      return;
    }
    _users.add(user);
    await _createUser(user);
  }

  static Future<void> removeUser(String user) async {
    _users.remove(user);
    final appdir = await getApplicationSupportDirectory();
    final usersdir = Directory('${appdir.path}/users');
    final userfile = File('${usersdir.path}/$user');
    userfile.deleteSync();
  }

  static Future<void> clearUsers() async {
    _users.clear();
    final appdir = await getApplicationSupportDirectory();
    final usersdir = Directory('${appdir.path}/users');
    usersdir.deleteSync(recursive: true);
  }
}
