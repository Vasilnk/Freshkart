import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CoverImagesWidget extends StatelessWidget {
  final List<String> images;
  const CoverImagesWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageHeight = MediaQuery.of(context).size.height * 0.22;
        if (constraints.maxWidth > 600) {
          imageHeight = MediaQuery.of(context).size.width * 0.32;
        }
        return CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, ind) {
            final image = images[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: imageHeight,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            scrollDirection: Axis.horizontal,
            initialPage: 0,
            viewportFraction: 1.0,
          ),
        );
      },
    );
  }
}
