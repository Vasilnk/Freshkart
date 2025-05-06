import 'package:flutter/material.dart';
import 'package:freshkart/core/routes.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/core/utils/images.dart';
import 'package:freshkart/view_model/providers/category_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final dynamic category;
  final int index;
  const CategoryCard({super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    final imageUrl = category['imageUrl'];
    final name = category['name'];
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.colors.keys.elementAt(index),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.colors.values.elementAt(index)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 110,
                width: 110,
                child: Image.network(
                  imageUrl!,
                  loadingBuilder: (context, child, imageLoading) {
                    if (imageLoading == null) {
                      return child;
                    } else {
                      return Image.asset(AppImages.logoNoBackground);
                    }
                  },
                ),
              ),
              Text(
                name!,

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          context.read<CategoryProvider>().setCategoryName = name;
          context.push(Routes.productsScreen);
        },
      ),
    );
  }
}
