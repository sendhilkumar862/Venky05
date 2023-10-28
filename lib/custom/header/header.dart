import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HeaderPage extends StatefulWidget {
  const HeaderPage({super.key});

  @override
  State<HeaderPage> createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/building_animation.json',
            controller: _controller,
            onLoaded: (composition) {
              _controller.duration = composition.duration;
            },
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () => _controller.stop(),
                  child: const Text('Pause')),
              ElevatedButton(
                  onPressed: () => _controller.forward(),
                  child: const Text('Resume')),
              ElevatedButton(
                  onPressed: () {
                    _controller.reset();
                    _controller.forward();
                  },
                  child: const Text('Repeat'))
            ],
          )
        ],
      ),
    );
  }
}
