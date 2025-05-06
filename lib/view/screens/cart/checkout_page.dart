import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view_model/providers/address_provider.dart';
import 'package:freshkart/view_model/providers/payment_provider.dart';
import 'package:freshkart/view/screens/cart/confirm_screen.dart';
import 'package:freshkart/core/utils/styles.dart';
import 'package:freshkart/view/widgets/address_section/add_address_container.dart';
import 'package:freshkart/view/widgets/address_section/addresses.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';
import 'package:freshkart/view/widgets/cart_section/checkout_price_details.dart';
import 'package:freshkart/view/widgets/cart_section/payment_section.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

class CheckoutPage extends StatefulWidget {
  final ProductModel? product;
  final bool? isBuyNow;

  const CheckoutPage({super.key, this.product, this.isBuyNow = false});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddressProvider>(context, listen: false).getAllAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Checkout'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Addresses(),

              const AddAddressContainer(),
              const PaymentMethodScreen(),
              const SizedBox(height: 20),

              CheckoutPriceDetails(
                isBuyNow: widget.isBuyNow,
                product: widget.product,
              ),
              const Divider(),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  if (context.read<AddressProvider>().selectedAddress == null) {
                    showSnackBar(context);

                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (c) => ConfirmScreen(
                            isBuyNow: widget.isBuyNow,
                            product: widget.product,
                          ),
                    ),
                  );
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
                          'Place Order',
                          style: AppStyles.bigButtonTextStyle,
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSnackBar(BuildContext context) {
    Flushbar(
      message: 'Please select an address',
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }
}
