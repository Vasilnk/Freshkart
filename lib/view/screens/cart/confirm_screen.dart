import 'package:flutter/material.dart';
import 'package:freshkart/models/cart_item_model.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view_model/providers/address_provider.dart';
import 'package:freshkart/view_model/providers/cart_provider.dart';
import 'package:freshkart/view_model/providers/payment_provider.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/core/utils/styles.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';
import 'package:freshkart/view/widgets/cart_section/checkout_price_details.dart';
import 'package:provider/provider.dart';

class ConfirmScreen extends StatelessWidget {
  final ProductModel? product;
  final bool? isBuyNow;

  const ConfirmScreen({super.key, this.product, this.isBuyNow = false});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = context.read<PaymentProvider>();
    final cartProvider = context.read<CartProvider>();
    final addressProvider = context.read<AddressProvider>();
    final address = addressProvider.selectedAddress;
    return Scaffold(
      appBar: const CustomAppbar(title: 'Confirm Order'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              const SizedBox(height: 10),
              customText("   Selected Address", false),

              Card(
                color: const Color.fromARGB(255, 65, 64, 119),

                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child:
                      address == null
                          ? const Text("No address selected")
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              customText(address['name']),
                              customText(address['houseName']),
                              customText(address['locality']),
                              customText(address['city']),
                              customText("Pincode: ${address['pincode']}"),
                              customText("Phone: ${address['phone']}"),
                            ],
                          ),
                ),
              ),
              customText("   Payment Option", false),
              Card(
                elevation: 3,
                color: AppColors.greenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          paymentProvider.paymentOption == 0
                              ? 'Online Payment (Credit/ Debit)'
                              : 'Cash On Delivery',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(),
              const Text(
                "Price Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),

              CheckoutPriceDetails(isBuyNow: isBuyNow, product: product),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final totalPrice =
                          isBuyNow == true
                              ? num.parse(
                                    product!.offer
                                        ? product!.offerPrice
                                        : product!.price,
                                  ) +
                                  35
                              : cartProvider.total + 35;
                      List<CartItemModel> items = [];

                      if (isBuyNow == true) {
                        items.add(
                          CartItemModel(
                            productId: product!.name,
                            quantity: 1,
                            price: num.parse(product!.price),
                          ),
                        );
                      } else {
                        items = List.from(cartProvider.cartItems);
                      }
                      final paidStatus =
                          paymentProvider.paymentOption == 0
                              ? 'Paid'
                              : 'Not Paid';

                      final Map<String, dynamic> map = {
                        'items': items,
                        'address': address,
                        'paidStatus': paidStatus,
                        'price': totalPrice,
                      };
                      if (paymentProvider.paymentOption == 0) {
                        await paymentProvider.makeOnlinePayment(
                          totalPrice,
                          context,
                          map,
                          isBuyNow ?? false,
                        );
                      } else {
                        paymentProvider.processingCashonDelivery(
                          context,
                          map,
                          isBuyNow ?? false,
                        );
                      }
                    },

                    style: AppStyles.bigButton,
                    child: Consumer<PaymentProvider>(
                      builder: (context, provider, child) {
                        return provider.loading
                            ? const Center(
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              ),
                            )
                            : Text(
                              'Confirm Order',
                              style: AppStyles.bigButtonTextStyle,
                            );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  customText(String text, [bool address = true]) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: address ? Colors.white : Colors.black,
      ),
    );
  }
}
