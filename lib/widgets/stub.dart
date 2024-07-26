import 'package:flutter/material.dart';

class Stub extends StatelessWidget {
  final String text;
  const Stub(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
