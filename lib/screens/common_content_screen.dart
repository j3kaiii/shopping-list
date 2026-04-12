import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list_example/application/consts.dart';
import 'package:shopping_list_example/utils/context_extension.dart';

class CommonContentScreen extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget child;
  final VoidCallback? onFABPressed;
  final bool showBackButton;
  final String? bottomButtonText;
  final VoidCallback? onBottomButtonPressed;
  const CommonContentScreen({
    super.key,
    required this.title,
    required this.child,
    this.actions,
    this.onFABPressed,
    this.showBackButton = false,
    this.bottomButtonText,
    this.onBottomButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: theme.titleH2TextStyle),
        centerTitle: true,
        actions: actions,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
      ),
      drawer: showBackButton ? null : _buildMenu(context),
      body: child,
      bottomNavigationBar:
          bottomButtonText != null && onBottomButtonPressed != null
              ? _buildBottomButton(context)
              : null,
      floatingActionButton: onFABPressed != null
          ? IconButton.filled(
              iconSize: 40.0,
              onPressed: onFABPressed,
              icon: const Icon(Icons.add),
              style: context.theme.iconButtonStyle,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onBottomButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B3BFF),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bottomButtonText!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.add_circle_outline),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    final theme = context.theme;
    final loc = context.loc;
    return Builder(
      builder: (menuContext) => Container(
        color: theme.secondaryBgColor,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsetsGeometry.all(18.0),
          child: Column(
            children: [
              _buildLogo(context),
              _buildMenuButtom(menuContext, loc.listsScreenTitle, root),
              _buildMenuButtom(
                  menuContext, loc.productsScreenTitle, commonProducts),
              // _buildMenuButtom(menuContext, loc.settingsScreenTitle, root),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildMenuButtom(
    BuildContext context,
    String title,
    String routeName,
  ) {
    return TextButton(
      onPressed: () => _goToRoute(context, routeName),
      child: Text(
        title,
        style: context.theme.buttonTextStyle,
      ),
    );
  }

  void _goToRoute(BuildContext context, String name) {
    Scaffold.of(context).closeDrawer();
    if (name == root) {
      context.goNamed(name);
    } else {
      context.pushNamed(name);
    }
  }

  Widget _buildLogo(BuildContext context) {
    return const SizedBox(height: 50);
  }
}
