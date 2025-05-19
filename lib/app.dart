import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_theme.dart';
import 'users/providers.dart';
import 'users/login.dart';
import 'home/home.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: FutureBuilder(
        future: ref.read(userProvider.notifier).initialize(),
        builder: (context, asyncSnapshot) {
          return asyncSnapshot.data == null ? LoginPage() : HomePage();
        },
      ),
    );
  }
}
