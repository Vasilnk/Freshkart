import 'package:flutter/material.dart';
import 'package:freshkart/view/widgets/home_section/search_container.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:freshkart/view/widgets/cover_image/cover_image_slider.dart';
import 'package:freshkart/view/widgets/home_section/home_categories_list.dart';
import 'package:freshkart/view/widgets/home_section/home_product_list.dart';
import 'package:freshkart/view/widgets/home_section/home_title_row.dart';
import 'package:freshkart/view/widgets/home_section/top_section.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double height = 210;
              if (constraints.maxWidth > 600) {
                height = 210;
              }
              return SingleChildScrollView(
                child: Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopSection(),

                    const SearchContainer(),

                    const CoverImageSlider(),
                    const HorizontalCategoriesList(),
                    HomeHorizondalProductsTitleRow(
                      title: 'Today Offer',
                      products: context.watch<ProductProvider>().offerProducts,
                    ),
                    SizedBox(
                      height: height,
                      child: Consumer<ProductProvider>(
                        builder:
                            (context, value, child) =>
                                HorizondalHomeProductsView(
                                  products: value.offerProducts,
                                  isOffer: true,
                                ),
                      ),
                    ),
                    HomeHorizondalProductsTitleRow(
                      title: 'Suggested',
                      products: context.watch<ProductProvider>().allProducts,
                    ),
                    SizedBox(
                      height: height,
                      child: Consumer<ProductProvider>(
                        builder:
                            (context, value, child) =>
                                HorizondalHomeProductsView(
                                  products: value.allProducts,
                                ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
