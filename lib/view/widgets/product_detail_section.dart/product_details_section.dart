import 'dart:async';
import 'package:flutter/material.dart';
import 'package:freshkart/models/product_model.dart';
import 'package:freshkart/view/widgets/product_detail_section.dart/similar_product_section.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsSection extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsSection({super.key, required this.product});

  @override
  State<ProductDetailsSection> createState() => _ProductDetailsSectionState();
}

class _ProductDetailsSectionState extends State<ProductDetailsSection> {
  late Duration remainingTime;
  List<ProductModel> similarProducts = [];
  num percentage = 0;

  @override
  void initState() {
    super.initState();
    similarProducts =
        context
            .read<ProductProvider>()
            .allProducts
            .where(
              (item) =>
                  item.categoryName == widget.product.categoryName &&
                  item.name != widget.product.name,
            )
            .toList();
    int hour = DateTime.now().hour;
    int minut = DateTime.now().minute;
    remainingTime = Duration(hours: 24 - hour, minutes: minut - 60);
    if (widget.product.offer) {
      _startTimer();
    }
    int price = int.tryParse(widget.product.price) ?? 0;
    int offerPrice = int.tryParse(widget.product.offerPrice) ?? 0;
    percentage = ((price - offerPrice) / price * 100).round();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds <= 0) {
        timer.cancel();
      } else {
        setState(() {
          remainingTime = remainingTime - const Duration(seconds: 1);
        });
      }
    });
  }

  String formatTime(Duration d) {
    return '${d.inHours.toString().padLeft(2, '0')}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '${product.quantity} ${product.unitType}',
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),

          const SizedBox(height: 16),

          Row(
            spacing: 10,
            children: [
              Row(
                children: [
                  Text(
                    '₹${product.offer ? product.offerPrice : product.price}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (product.offer)
                    Text(
                      '₹${product.price}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
              product.offer
                  ? Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '$percentage% OFF',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  )
                  : const SizedBox.shrink(),
              // const DynamicQuantityInput(),
            ],
          ),

          const SizedBox(height: 16),

          product.offer
              ? Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Sale ends in ${formatTime(remainingTime)}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : const SizedBox.shrink(),

          const SizedBox(height: 16),

          const Row(
            children: [
              Icon(Icons.flash_on, color: Colors.green),
              SizedBox(width: 8),
              Text('Express Delivery by Today', style: TextStyle(fontSize: 15)),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.payments_outlined, color: Colors.blue),
              SizedBox(width: 8),
              Text('Pay on Delivery Available', style: TextStyle(fontSize: 15)),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.cancel, color: Colors.red),
              SizedBox(width: 8),
              Text('No Return Available', style: TextStyle(fontSize: 15)),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            'Product Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),

          const SizedBox(height: 24),

          const Text(
            'Similar Products',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SimilarProductSection(similarProducts: similarProducts),
        ],
      ),
    );
  }
}
