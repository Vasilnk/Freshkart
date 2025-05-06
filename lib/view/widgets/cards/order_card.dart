import 'package:flutter/material.dart';
import 'package:freshkart/view/screens/account/order/order_detail_screen.dart';
import 'package:freshkart/core/utils/colors.dart';
import 'package:freshkart/core/utils/styles.dart';

class OrderCard extends StatelessWidget {
  final order;
  final orderNumber;
  final date;
  final time;
  final deliveryDate;

  const OrderCard({
    super.key,
    required this.order,
    required this.orderNumber,
    required this.date,
    required this.time,
    required this.deliveryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 13,
                  children: [
                    Text(
                      'Order No:  ${orderNumber.toString().substring(5, 11)}',
                      style: AppStyles.mediumTextStyle,
                    ),
                    Text(
                      'Items : ${order['items'].length}',
                      style: AppStyles.mediumTextStyle,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (c) => OrderDetailScreen(
                                  order: order,
                                  orderId: orderNumber,
                                  orderDate: date,
                                  time: time,
                                  deliveryTime: deliveryDate,
                                ),
                          ),
                        );
                      },
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greenColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 30,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹ ${order['totalPrice']}',
                      style: AppStyles.mediumTextStyle,
                    ),
                    Text(
                      '${order['orderStatus']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greenColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
