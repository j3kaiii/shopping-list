import 'package:flutter/material.dart';

class CommonContentScreen extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final Widget child;
  const CommonContentScreen({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: actions,
      ),
      body: child,
    );
  }
}
