import 'package:flutter/material.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:freshkart/view_model/providers/order_provider.dart';
import 'package:freshkart/view_model/providers/product_provider.dart';
import 'package:freshkart/core/utils/styles.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';
import 'package:freshkart/view/widgets/order/status.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  final String orderId;
  final String orderDate;
  final String time;
  final String deliveryTime;

  const OrderDetailScreen({
    super.key,
    required this.order,
    required this.orderId,
    required this.orderDate,
    required this.time,
    required this.deliveryTime,
  });

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      appBar: const CustomAppbar(title: 'Order Summary'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 12,
          children: [
            buildOrderHeader(context),
            buildOrderStatus(),

            Row(
              children: [
                Expanded(flex: 1, child: buildDeliveryAddress()),
                Expanded(flex: 1, child: buildPaymentInfo()),
              ],
            ),
            buildProductSection(orderProvider, context),
          ],
        ),
      ),
    );
  }

  Widget buildOrderHeader(BuildContext context) {
    return Card(
      color: AppColors.greenColor,

      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addressText('Order ID', order['orderId']),
            addressText('Order Date', orderDate),
            addressText('Order Time', time),
            addressText('Estimated Delivery', deliveryTime),
            addressText('Total Amount', '₹${order['totalPrice']}'),
          ],
        ),
      ),
    );
  }

  Widget buildProductSection(OrderProvider provider, BuildContext context) {
    return Card(
      color: provider.isExpanded ? Colors.white : Colors.green[100],
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Order Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () => provider.expand = !provider.isExpanded,
                  icon: Icon(
                    provider.isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ),
              ],
            ),
            if (provider.isExpanded) ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order['items'].length,
                itemBuilder: (context, index) {
                  final item = order['items'][index];
                  final product = context
                      .read<ProductProvider>()
                      .allProducts
                      .firstWhere((p) => p.name == item['productId']);

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.images[0],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(product.name, style: AppStyles.mediumTextStyle),
                    subtitle: Text(
                      '${product.quantity} ${product.unitType} • Qty: ${item['quantity']}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                    trailing: Text(
                      '₹${item['price']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              const Divider(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Price Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              priceRow('Subtotal', '₹${order['totalPrice'] - 35}'),
              priceRow('Delivery Charge', '₹35'),
              priceRow('Discount', 'Not added'),
              const Divider(),
              priceRow('Total', '₹${order['totalPrice']}', isBold: true),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildDeliveryAddress() {
    final address = order['address'];
    return Card(
      color: const Color.fromARGB(255, 183, 183, 201),

      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(address['name']),
            Text(address['locality']),
            Text(address['pincode']),
            Text('Phone: ${address['phone']}'),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentInfo() {
    final paid = order['paidStatus'] == 'paid';
    return Card(
      color: Colors.green[100],

      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Info',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(paid ? 'Online Payment' : 'Cash on Delivery'),
            const SizedBox(height: 10),

            Text('Status: ${paid ? 'Paid' : 'Not Paid'}'),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildOrderStatus() {
    return Consumer<OrderProvider>(
      builder:
          (context, provider, _) => Card(
            color: Colors.white,

            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Order -  ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          order['orderStatus'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.greenColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed:
                            () =>
                                provider.orderExpand =
                                    !provider.isOrderExpanded,
                        icon: Icon(
                          provider.isOrderExpanded
                              ? Icons.expand_less
                              : Icons.expand_more,
                        ),
                      ),
                    ],
                  ),
                  if (provider.isOrderExpanded) ...[
                    const SizedBox(height: 8),
                    OrderTrackingScreen(currentStatus: order['orderStatus']),
                  ],
                ],
              ),
            ),
          ),
    );
  }

  Widget addressText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget priceRow(String label, String amount, {bool isBold = false}) {
    final style =
        isBold
            ? const TextStyle(fontWeight: FontWeight.bold)
            : const TextStyle(color: Colors.black87);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(amount, style: style)],
      ),
    );
  }
}
