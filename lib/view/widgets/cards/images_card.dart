import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freshkart/view/widgets/cart_section/cart_icon_withcount.dart';
import 'package:freshkart/view/widgets/product_detail_section.dart/image_animation_controller.dart';

class ImagesSection extends StatefulWidget {
  final List<String> images;
  final double width;

  const ImagesSection({super.key, required this.images, required this.width});

  @override
  State<ImagesSection> createState() => _ImagesSectionState();
}

class _ImagesSectionState extends State<ImagesSection> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Stack(
          children: [
            Container(
              width: widget.width,
              height: 350,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.touch,
                    },
                  ),
                  child: PageView.builder(
                    itemCount: widget.images.length,
                    onPageChanged: (index) {
                      setState(() => currentIndex = index);
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.images[index],
                        fit: BoxFit.fitHeight,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder:
                            (context, error, stackTrace) => const Center(
                              child: Icon(Icons.broken_image, size: 50),
                            ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const CartIconWithCount(),
          ],
        ),
        ImageAnimationController(
          currentIndex: currentIndex,
          length: widget.images.length,
        ),
      ],
    );
  }
}
