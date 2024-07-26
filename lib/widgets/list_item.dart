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
    return Card.outlined(
      color: color,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(name),
        ),
      ),
    );
  }
}
