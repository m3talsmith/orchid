import 'package:flutter/material.dart';
import '../ui/app_container.dart';
import '../apps/notes/home.dart';

class AppNavigationBarAppsDialog extends StatelessWidget {
  const AppNavigationBarAppsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onSurface.withAlpha(100),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.33),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width ~/ 256,
              ),
              children: [
                AppNavigationBarApp(
                  name: 'Notes',
                  icon: Icons.notes_rounded,
                  onPressed:
                      () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const NotesHomeView(),
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppNavigationBarApp extends StatelessWidget {
  const AppNavigationBarApp({
    super.key,
    required this.name,
    required this.icon,
    required this.onPressed,
  });

  final String name;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AppContainer(child: Column(children: [Icon(icon), Text(name)])),
    );
  }
}
