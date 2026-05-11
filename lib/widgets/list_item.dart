import 'package:flutter/material.dart';
import 'package:shopping_list_example/application/theme.dart';
import 'package:shopping_list_example/utils/context_extension.dart';

class ListItem extends StatelessWidget {
  final String name;
  final int? quantity;
  final Color? color;
  final bool isButton;
  final VoidCallback? onTap;

  const ListItem({
    super.key,
    required this.name,
    this.quantity,
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
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: isButton
                        ? theme.buttonTextStyle
                        : theme.defaultTextStyle,
                  ),
                ),
                if (quantity != null && quantity! > 0)
                  _buildQuantity(context, theme)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantity(BuildContext context, ShoppingThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        'x$quantity',
        style: theme.defaultTextStyle?.copyWith(fontSize: 14),
      ),
    );
  }
}
