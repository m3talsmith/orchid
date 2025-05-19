import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../users/providers.dart';
import '../app.dart';
import 'app_navigation_bar_apps_drawer.dart';
import '../apps/notes/providers.dart';

class AppNavigationBar extends ConsumerWidget {
  final List<AppNavigationBarAction> actions;
  final bool showBackButton;

  const AppNavigationBar({
    super.key,
    this.actions = const [],
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedActionIndex = ref.watch(selectedActionIndexProvider);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppNavigationBarAction(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      fullscreenDialog: true,
                      opaque: false,
                      barrierDismissible: true,
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              AppNavigationBarAppsDialog(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  );
                },
                icon: Icons.apps_rounded,
                label: 'Applications',
              ),
              if (actions.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Column(
                    children: [
                      ...actions.map((action) {
                        final index = actions.indexOf(action);
                        return action.copyWith(
                          selected:
                              selectedActionIndex != null &&
                              selectedActionIndex == index,
                          onPressed: () {
                            ref
                                .read(selectedActionIndexProvider.notifier)
                                .state = index;
                            action.onPressed();
                          },
                        );
                      }),
                    ],
                  ),
                ),
              AppNavigationBarAction(
                onPressed: () {
                  ref.read(userProvider.notifier).logout();
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => App()));
                },
                icon: Icons.logout_rounded,
                label: 'Logout',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppNavigationBarAction extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  final String? label;
  final bool selected;
  final bool expanded;
  final double? width;

  const AppNavigationBarAction({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
    this.selected = false,
    this.expanded = false,
    this.width,
  });

  AppNavigationBarAction copyWith({
    bool expanded = false,
    bool selected = false,
    double? width,
    void Function()? onPressed,
  }) {
    return AppNavigationBarAction(
      icon: icon,
      onPressed: onPressed ?? this.onPressed,
      label: label,
      selected: selected,
      expanded: expanded,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primary : null,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        width: width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              decoration: BoxDecoration(
                border:
                    selected
                        ? Border(
                          right: BorderSide(
                            color: Theme.of(context).colorScheme.surface,
                            width: 2,
                          ),
                        )
                        : null,
              ),
              margin: EdgeInsets.all(8),
              child: Icon(
                icon,
                color:
                    selected
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            if (label != null && expanded)
              Container(
                padding: const EdgeInsets.all(8),
                width: width != null ? width! - 40 : null,
                child: Text(
                  label!,
                  style: TextStyle(
                    color:
                        selected
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
