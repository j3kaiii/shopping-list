import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_list_example/application/consts.dart';

/// Загрузочный экран.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const image = 'assets/images/image.png';
    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(image),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.goNamed(root),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.lightBlue),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Go shopping',
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
