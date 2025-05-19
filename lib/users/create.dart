import 'package:flutter/material.dart';
import '../models/user.dart';
import 'login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../ui/app_screen_container.dart';
import '../ui/app_container.dart';

class CreateUserPage extends ConsumerStatefulWidget {
  const CreateUserPage({super.key});
  @override
  CreateUserPageState createState() => CreateUserPageState();
}

class CreateUserPageState extends ConsumerState<CreateUserPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool showPassword = false;

  Future<void> createUser() async {
    if (usernameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Username is required')));
      return;
    }
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Password is required')));
      return;
    }
    if (passwordController.text != passwordConfirmController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Passwords do not match')));
      return;
    }
    final nav = Navigator.of(context);
    final _ = await User.create(
      password: passwordController.text,
      salt: usernameController.text,
    );
    nav.push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenContainer(
        child: AppContainer(
          width: MediaQuery.of(context).size.width * 0.66,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              Text(
                'Create User',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                onSubmitted: (value) {
                  createUser();
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
                      showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  createUser();
                },
                obscureText: !showPassword,
              ),
              TextField(
                controller: passwordConfirmController,
                decoration: InputDecoration(
                  labelText: 'Password Confirmation',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  createUser();
                },
                obscureText: !showPassword,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  onPressed: createUser,
                  child: Text('Create User'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
