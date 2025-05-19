import 'package:flutter/material.dart';
import 'app_navigation_bar.dart';

class AppScreenContainer extends StatelessWidget {
  final Widget child;
  final AppNavigationBar? navigationBar;

  const AppScreenContainer({
    super.key,
    required this.child,
    this.navigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (navigationBar != null) navigationBar!,
          Expanded(
            child: Padding(padding: const EdgeInsets.all(16.0), child: child),
          ),
        ],
      ),
    );
  }
}
