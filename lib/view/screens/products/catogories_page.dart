import 'package:flutter/material.dart';
import 'package:freshkart/core/routes.dart';
import 'package:freshkart/view_model/providers/category_provider.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';
import 'package:freshkart/view/widgets/cards/category_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CatogoriesPage extends StatelessWidget {
  const CatogoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Categories'),
      body: Padding(
        padding: const EdgeInsets.all(11),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: InkWell(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.search),
                      Text(
                        'Search Poduct',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                onTap: () => context.push(Routes.search),
              ),
            ),
            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (context, value, child) {
                  final categories = value.categories;
                  if (value.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.greenColor,
                      ),
                    );
                  } else if (categories.isEmpty) {
                    const Center(child: Text('No data'));
                  }
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 2;
                      double childAspetRatio = 0.94;
                      if (constraints.maxWidth > 950) {
                        crossAxisCount = 6;
                        childAspetRatio = 0.9;
                      } else if (constraints.maxWidth > 700) {
                        crossAxisCount = 5;
                        childAspetRatio = 0.7;
                      } else if (constraints.maxWidth > 550) {
                        crossAxisCount = 4;
                        childAspetRatio = 0.7;
                      } else if (constraints.maxWidth > 450) {
                        crossAxisCount = 3;
                        childAspetRatio = 0.85;
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: childAspetRatio,
                        ),
                        itemCount: value.categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          return CategoryCard(category: category, index: index);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
