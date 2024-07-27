import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String name;
  final Color? color;
  final VoidCallback? onTap;

  const ListItem({
    super.key,
    required this.name,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card.outlined(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(name),
        ),
      ),
    );
  }
}
