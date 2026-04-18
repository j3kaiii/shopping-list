import 'package:flutter/material.dart';
import 'package:shopping_list_example/utils/context_extension.dart';

class ListItem extends StatelessWidget {
  final String name;
  final Color? color;
  final bool isButton;
  final VoidCallback? onTap;

  const ListItem({
    super.key,
    required this.name,
    this.color,
    this.onTap,
    this.isButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Card.outlined(
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              name,
              style: isButton ? theme.buttonTextStyle : theme.defaultTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
