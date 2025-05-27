import 'package:flutter/material.dart';
import 'package:orchid/ui/app_container.dart';
import 'package:orchid/ui/app_screen_container.dart';
import '../models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../users/providers.dart';
import '../app.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;

  void login() async {
    final nav = Navigator.of(context);
    final user = await User.login(
      password: passwordController.text,
      salt: usernameController.text,
    );
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid password')));
      return;
    }
    ref.read(userProvider.notifier).login(user.id!);
    nav.push(MaterialPageRoute(builder: (context) => App()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenContainer(
        child: Column(
          children: [
            AppContainer(
              width: MediaQuery.of(context).size.width * 0.66,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.25,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    onSubmitted: (value) {
                      login();
                    },
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    onSubmitted: (value) {
                      login();
                    },
                    obscureText: !showPassword,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FilledButton(onPressed: login, child: Text('Login')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
