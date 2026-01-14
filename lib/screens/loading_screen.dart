import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/utils/context_extension.dart';

/// Загрузочный экран.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const image = 'assets/images/logo.png';
    final theme = context.theme;
    return Material(
      color: theme.primaryBgColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(image),
            ),
            ElevatedButton(
              onPressed: () => context.goNamed(root),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(theme.secondaryBgColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  context.loc.welcomeScreenTitle,
                  style: TextStyle(fontSize: 26, color: theme.primaryBgColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
