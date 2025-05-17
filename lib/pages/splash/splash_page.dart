import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    required this.loadingFuture,
    super.key,
  });

  final Future<void> Function() loadingFuture;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final scaleNotifier = ValueNotifier<double>(0);
  bool completed = false;

  @override
  void initState() {
    super.initState();

    widget.loadingFuture.call().then((_) {
      setState(() {
        completed = true;
      });
    });

    Future.delayed(
      const Duration(milliseconds: 100),
      () => scaleNotifier.value = 1,
    );
  }

  @override
  void dispose() {
    scaleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: scaleNotifier,
        builder: (context, scale, _) {
          return Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 450),
              scale: scale,
              child: Image.asset(
                'assets/images/brinquedo_track_logo.png',
              ),
              onEnd: () {
                if (!completed) {
                  scaleNotifier.value = scale == 1 ? 0.8 : 1;
                }
              },
            ),
          );
        },
      ),
    );
  }
}
