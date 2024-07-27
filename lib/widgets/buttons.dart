import 'package:flutter/material.dart';
import 'package:shopping_list_example/utils/context_extension.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CancelButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.cancel),
      label: Text(context.loc.btnCancel),
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
    final loc = context.loc;
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(inProgress ? Icons.check : Icons.add),
      label: Text(inProgress ? loc.btnOk : loc.btnAdd),
    );
  }
}
