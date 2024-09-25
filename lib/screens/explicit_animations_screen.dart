import 'package:flutter/material.dart';

class ExplicitAnimationsScreen extends StatefulWidget {
  const ExplicitAnimationsScreen({super.key});

  @override
  State<ExplicitAnimationsScreen> createState() =>
      _ExplicitAnimationsScreenState();
}

class _ExplicitAnimationsScreenState extends State<ExplicitAnimationsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )
    ..addListener(() {
      _value.value = _animationController.value;
    })
    ..addStatusListener((status) {
      print(status);
    });

  late final CurvedAnimation _curved = CurvedAnimation(
    parent: _animationController,
    curve: Curves.elasticInOut,
    reverseCurve: Curves.bounceOut,
  );

  late final Animation<Decoration> _decoration = DecorationTween(
          begin: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(20)),
          end: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(200)))
      .animate(_curved);

  late final Animation<double> _rotation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(_curved);

  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 0.8,
  ).animate(_curved);

  void _play() {
    _animationController.forward();
  }

  void _pause() {
    _animationController.stop();
  }

  void _rewind() {
    _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final ValueNotifier<double> _value = ValueNotifier(0.0);

  void _onChanged(double value) {
    _animationController.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explicit Animation Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scale,
              child: RotationTransition(
                turns: _rotation,
                child: DecoratedBoxTransition(
                  decoration: _decoration,
                  child: const SizedBox(
                    height: 400,
                    width: 400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _play,
                  child: const Text("Play"),
                ),
                ElevatedButton(
                  onPressed: _pause,
                  child: const Text("Pause"),
                ),
                ElevatedButton(
                  onPressed: _rewind,
                  child: const Text("Rewind"),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            ValueListenableBuilder(
              valueListenable: _value,
              builder: (context, value, child) {
                return Slider(
                  value: _value.value,
                  onChanged: _onChanged,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
