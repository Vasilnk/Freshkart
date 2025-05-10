import 'package:flutter/material.dart';
import 'package:freshkart/core/routes.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:freshkart/view_model/providers/wishlist_provider.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/core/utils/images.dart';
import 'package:freshkart/view/widgets/home_section/offer_tag.dart';
import 'package:freshkart/view/widgets/icons/wishlist_icon.dart';
import 'package:freshkart/view/widgets/tiles/toast_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      child: Stack(
        children: [
          Container(
            // width: width * 0.436,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      fit: BoxFit.contain,
                      product.images[0],
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Image.asset(AppImages.logoNoBackground);
                      },
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${product.quantity}  ${product.unitType}'),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        product.offer
                            ? Row(
                              spacing: 3,
                              children: [
                                Text(
                                  '₹ ${product.offerPrice}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Text(
                                      ' ${product.price}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const Positioned(
                                      top: 2,
                                      left: 2,
                                      right: 0,
                                      child: Divider(
                                        thickness: 1,
                                        color: Color.fromARGB(
                                          255,
                                          185,
                                          184,
                                          184,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                            : Text(
                              '₹ ${product.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color:
                                    product.offer
                                        ? const Color.fromARGB(255, 13, 62, 145)
                                        : Colors.black,
                              ),
                            ),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(color: AppColors.greenColor),
                            ),
                            child: Text(
                              'Add',
                              style: TextStyle(color: AppColors.greenColor),
                            ),
                          ),
                          onTap: () {
                            context.read<CartProvider>().addToCart(
                              name: product.name,
                              price:
                                  product.offer
                                      ? num.parse(product.offerPrice)
                                      : num.parse(product.price),
                            );
                            showToast('${product.name} Added to cart');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          product.offer
              ? Positioned(
                top: 0,
                left: 0,
                child: OfferTag(
                  offerPrice: product.offerPrice,
                  price: product.price,
                ),
              )
              : const SizedBox.shrink(),
          Positioned(
            right: -2,
            top: -4,
            child: Consumer<WshlistProvider>(
              builder: (context, value, child) {
                final isFavorite = value.favoriteProductIds.contains(
                  product.name,
                );
                return WishlistIconButton(
                  isFavorite: isFavorite,
                  value: value,
                  name: product.name,
                );
              },
            ),
          ),
        ],
      ),
      onTap: () {
        context.read<ProductProvider>().setSelectedProduct = product;
        context.push(Routes.productPage);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (c) {
        //       return ProductPage(product: product);
        //     },
        //   ),
        // );
      },
    );
  }
}
