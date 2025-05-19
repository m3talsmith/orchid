import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model.dart';
import 'form.dart';
import '../../ui/app_screen_container.dart';
import '../../ui/app_navigation_bar.dart';
import '../../ui/app_container.dart';
import 'navbar.dart';
import 'providers.dart';

class NotesCreate extends ConsumerWidget {
  const NotesCreate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(selectedActionIndexProvider.notifier).state = 1;
    });

    return Scaffold(
      body: AppScreenContainer(
        navigationBar: AppNavigationBar(
          actions: [
            ...navbarActions(context: context),
            AppNavigationBarAction(
              label: 'Save',
              icon: Icons.save,
              onPressed: () {},
            ),
          ],
        ),
        child: AppContainer(child: NotesForm(note: Note())),
      ),
    );
  }
}
