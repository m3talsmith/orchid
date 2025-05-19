import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ui/app_screen_container.dart';
import '../../ui/app_navigation_bar.dart';
import '../../ui/app_container.dart';
import 'create.dart';
import 'navbar.dart';
import 'providers.dart';

class NotesHomeView extends ConsumerWidget {
  const NotesHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(selectedActionIndexProvider.notifier).state = 0;
    });

    return Scaffold(
      body: AppScreenContainer(
        navigationBar: AppNavigationBar(
          actions: navbarActions(context: context),
        ),
        child: AppContainer(
          child: Column(
            children: [
              Text('Notes'),
              Expanded(
                child: Center(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotesCreate()),
                      );
                    },
                    label: Text('New Note'),
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
