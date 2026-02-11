import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/utils/context_extension.dart';

class CommonContentScreen extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget child;
  final VoidCallback? onFABPressed;
  const CommonContentScreen({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.onFABPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: theme.titleTextStyle),
        centerTitle: true,
        actions: actions,
      ),
      drawer: _buildMenu(context),
      body: child,
      floatingActionButton: onFABPressed != null
          ? FloatingActionButton(onPressed: onFABPressed)
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildMenu(BuildContext context) {
    final theme = context.theme;
    return Container(
      color: theme.secondaryBgColor,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsetsGeometry.all(18.0),
        child: Column(
          children: [
            _buildLogo(context),
            _buildMenuButtom(context, 'Main', () => context.goNamed(root)),
            _buildMenuButtom(
              context,
              'Products',
              () => context.goNamed(products),
            ),
            _buildMenuButtom(context, 'Settings', () => context.goNamed(root)),
          ],
        ),
      )),
    );
  }

  Widget _buildMenuButtom(
    BuildContext context,
    String title,
    void Function() onPressed,
  ) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: context.theme.buttonTextStyle,
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return const SizedBox(height: 50);
  }
}
