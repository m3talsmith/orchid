import 'dart:developer';

import 'package:flutter/material.dart';
import '../../ui/app_navigation_bar.dart';
import 'create.dart';
import 'home.dart';

List<AppNavigationBarAction> navbarActions({required BuildContext context}) {
  return [
    AppNavigationBarAction(
      label: 'Home',
      icon: Icons.home,
      onPressed:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotesHomeView()),
          ),
    ),
    AppNavigationBarAction(
      label: 'Create',
      icon: Icons.add,
      onPressed:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotesCreate()),
          ),
    ),
  ];
}
