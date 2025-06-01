import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:freshkart/view_model/providers/wishlist_provider.dart';
import 'package:freshkart/view/screens/landing_screen.dart';
import 'package:freshkart/view_model/services/user_services.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';
import 'package:freshkart/view/widgets/cards/product_card.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WishlistProvider>().getWishlistProducts(
        UserServices.currentUser!.uid,
        context.read<ProductProvider>().allProducts,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Wishlist'),
      body: Consumer<WishlistProvider>(
        builder: (context, value, child) {
          final products = value.favoriteProducts;

          return products.isNotEmpty
              ? GridView.builder(
                shrinkWrap: true,

                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductCard(product: product),
                  );
                },
              )
              : Center(
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No  wishlist yet!",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const LandingScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Add',
                        style: TextStyle(color: AppColors.greenColor),
                      ),
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }
}
