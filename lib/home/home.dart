import 'package:flutter/material.dart';
import '../ui/app_container.dart';
import '../ui/app_screen_container.dart';
import '../ui/app_navigation_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreenContainer(
        navigationBar: AppNavigationBar(),
        child: AppContainer(child: Text('Home')),
      ),
    );
  }
}
