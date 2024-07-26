import 'package:flutter/material.dart';
import 'package:shopping_list_example/widgets/buttons.dart';

typedef Validator = String? Function(String?);

class BottomPanel extends StatefulWidget {
  final bool isAdding;
  final VoidCallback onAddPressed;
  final VoidCallback onCancel;
  final double panelWidth;
  final TextEditingController textController;
  final Validator? validator;

  const BottomPanel({
    super.key,
    required this.isAdding,
    required this.onAddPressed,
    required this.onCancel,
    required this.panelWidth,
    required this.textController,
    this.validator,
  });

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  @override
  Widget build(BuildContext context) {
    final addButton = AddButton(
      onPressed: widget.onAddPressed,
      inProgress: widget.isAdding,
    );
    return widget.isAdding
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: widget.textController,
                  autofocus: true,
                  validator: (value) => widget.validator!(value),
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    hintText: 'Create name',
                    constraints: BoxConstraints(maxWidth: widget.panelWidth),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CancelButton(onPressed: widget.onCancel),
                  const SizedBox(width: 12),
                  addButton,
                ],
              )
            ],
          )
        : addButton;
  }
}
