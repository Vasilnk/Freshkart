import 'package:flutter/material.dart';

class ImageAnimationController extends StatelessWidget {
  final int length;
  final int currentIndex;
  const ImageAnimationController({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 12 : 8,
          height: currentIndex == index ? 12 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                currentIndex == index ? Colors.black87 : Colors.grey.shade400,
          ),
        );
      }),
    );
  }
}
