import 'package:flutter/material.dart';
import 'package:shopping_list_example/utils/context_extension.dart';

class CommonContentScreen extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget child;
  const CommonContentScreen({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: theme.titleTextStyle),
        centerTitle: true,
        backgroundColor: theme.secondaryBgColor,
        actions: actions,
      ),
      body: child,
    );
  }
}
