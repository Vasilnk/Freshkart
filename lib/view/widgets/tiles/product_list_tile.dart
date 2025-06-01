import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/view_model/providers/wishlist_provider.dart';
import 'package:freshkart/view/screens/products/single_product_page.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/view/widgets/icons/wishlist_icon.dart';
import 'package:freshkart/view/widgets/tiles/toast_tile.dart';
import 'package:provider/provider.dart';

class SearchBarProductTile extends StatelessWidget {
  // final String name;
  // final String image;
  // final String quantity;
  // final String price;
  // final String offerPrice;
  // final String unitType;
  // final images;
  // final String description;
  // final bool isOffer;
  final ProductModel product;
  const SearchBarProductTile({
    super.key,
    required this.product,
    // required this.name,
    // required this.image,
    // required this.quantity,
    // required this.price,
    // required this.offerPrice,
    // required this.unitType,
    // required this.images,
    // required this.description,
    // this.isOffer = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            spacing: 5,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.images[0],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${product.quantity} ${product.unitType}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    product.offer
                        ? Row(
                          spacing: 8,
                          children: [
                            Text(
                              product.offerPrice,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,

                                fontSize: 16,
                              ),
                            ),
                            Stack(
                              children: [
                                Text(
                                  product.price,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Positioned(
                                  top: 3,
                                  left: 2,
                                  right: 0,
                                  child: Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 185, 184, 184),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                        : Text(
                          product.price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                  ],
                ),
              ),
              Consumer<WishlistProvider>(
                builder: (context, value, child) {
                  final isFavorite = value.favoriteProductIds.contains(
                    product.name,
                  );
                  return WishlistIconButton(
                    isFavorite: isFavorite,
                    provider: value,
                    name: product.name,
                  );
                },
              ),
              Consumer<CartProvider>(
                builder: (context, provider, child) {
                  final isCartitem = provider.cartItems.any(
                    (item) => item.productId == product.name,
                  );
                  return InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                          color:
                              isCartitem ? AppColors.greenColor : Colors.black,
                        ),
                      ),
                      child: Text(
                        isCartitem ? 'Added' : '  Add  ',
                        style: TextStyle(
                          color:
                              isCartitem ? AppColors.greenColor : Colors.black,
                        ),
                      ),
                    ),
                    onTap: () {
                      isCartitem
                          ? provider.removeCartItem(product.name)
                          : provider.addToCart(
                            name: product.name,
                            price:
                                product.offer
                                    ? num.parse(product.offerPrice)
                                    : num.parse(product.price),
                          );
                      isCartitem
                          ? showToast(
                            '${product.name} Removed from cart',
                            false,
                          )
                          : showToast('${product.name} Added to cart');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductPage()),
        );
      },
    );
  }
}
