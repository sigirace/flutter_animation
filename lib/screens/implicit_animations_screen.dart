import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Implict Animations"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 10.0),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Text("$value");
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _trigger,
              child: const Text("Go!"),
            ),
          ],
        ),
      ),
    );
  }
}
