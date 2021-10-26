import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeTopViewWidget extends StatelessWidget {
  const HomeTopViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blueGrey
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarGlow(
            endRadius: 90,
            duration: const Duration(seconds: 2),
            glowColor: Colors.white24,
            repeat: true,
            repeatPauseDuration: const Duration(seconds: 2),
            startDelay: const Duration(seconds: 1),
            child: Material(
              elevation: 8.0,
              shape: const CircleBorder(),
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 50.0,
                child: Lottie.asset('assets/crawl.json',
                    repeat: true,
                    reverse: true,
                    animate: true,
                    height: 120,
                    width: 120),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
