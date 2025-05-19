import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final bool showBorder;

  const AppContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(0),
    this.backgroundColor,
    this.width,
    this.height,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border:
            showBorder
                ? Border.all(
                  color: const Color.fromARGB(255, 80, 80, 78),
                  width: 2,
                )
                : null,
        color: backgroundColor ?? const Color.fromARGB(255, 243, 243, 240),
      ),
      child: child,
    );
  }
}
