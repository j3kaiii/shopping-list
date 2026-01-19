import 'package:flutter/material.dart';
import 'package:shopping_list_example/utils/context_extension.dart';

class Stub extends StatelessWidget {
  final String text;
  const Stub(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, style: context.theme.hintTextStyle),
    );
  }
}
