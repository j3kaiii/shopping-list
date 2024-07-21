import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CancelButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.cancel),
      label: const Text('Cancel'),
    );
  }
}

class AddButton extends StatelessWidget {
  final bool inProgress;
  final VoidCallback onPressed;
  const AddButton({
    super.key,
    required this.onPressed,
    required this.inProgress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(inProgress ? Icons.check : Icons.add),
      label: Text(inProgress ? 'OK' : 'add'),
    );
  }
}
