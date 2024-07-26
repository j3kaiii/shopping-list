import 'package:flutter/material.dart';

class CommonContentScreen extends StatelessWidget {
  final String title;
  final Widget child;
  const CommonContentScreen(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: child,
    );
  }
}
