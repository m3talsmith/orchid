import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

final userProvider = AsyncNotifierProvider<UserProvider, User?>(
  () => UserProvider(),
);

enum UserProviderKeys { user }

class UserProvider extends AsyncNotifier<User?> {
  UserProvider() : super();

  @override
  Future<User?> build() async {
    return await initialize();
  }

  Future<User?> initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final id = sharedPreferences.getString(UserProviderKeys.user.name);
    state = AsyncData(id != null ? User(id: id) : null);
    return id != null ? User(id: id) : null;
  }

  void logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(UserProviderKeys.user.name);
    state = AsyncData(null);
  }

  void login(String userId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(UserProviderKeys.user.name, userId);
    state = AsyncData(User(id: userId));
  }
}
