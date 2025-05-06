import 'package:flutter/material.dart';
import 'package:freshkart/core/routes.dart';
import 'package:freshkart/view_model/providers/category_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HorizontalCategoriesList extends StatelessWidget {
  const HorizontalCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = 90;
        if (constraints.maxWidth > 600) {
          height = 150;
        }
        return SizedBox(
          height: height,
          child: Consumer<CategoryProvider>(
            builder: (context, value, child) {
              final categories = value.categories;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        spacing: 5,
                        children: [
                          Container(
                            height: height - 30,
                            width: height - 30,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(category['imageUrl']),
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          Text(
                            category['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      context.read<CategoryProvider>().setCategoryName =
                          category['name'];
                      context.push(Routes.productsScreen);
                    },
                  );
                },
                itemCount: categories.length,
              );
            },
          ),
        );
      },
    );
  }
}
