import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/cover_image_provider.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/view/widgets/cover_image/cover_images.dart';
import 'package:provider/provider.dart';

class CoverImageSlider extends StatelessWidget {
  const CoverImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CoverImageProvider>().getImages();

    return Consumer<CoverImageProvider>(
      builder: (context, value, child) {
        if (value.coverImages.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.greenColor),
          );
        } else {
          return CoverImagesWidget(images: value.coverImages);
        }
      },
    );
  }
}
