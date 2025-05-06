import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/order_provider.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';
import 'package:freshkart/view/widgets/cards/order_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderProvider>().getAllOrders();

    return Scaffold(
      appBar: const CustomAppbar(title: 'Orders'),
      body: Consumer<OrderProvider>(
        builder: (context, value, child) {
          if (value.orders.isEmpty) {
            return const Center(
              child: Text(
                'No orders yet',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final order = value.orders[index];
              final DateTime dateTime = order['orderTime'].toDate();
              final DateTime deliveryDateTime = order['delveryTime'].toDate();

              final String date = DateFormat("dd MMMM y").format(dateTime);

              final String deliveryDate = DateFormat(
                "dd MMMM y",
              ).format(deliveryDateTime);
              int hour = dateTime.hour;
              int minute = dateTime.minute;

              String period = hour >= 12 ? 'PM' : 'AM';
              hour = hour % 12 == 0 ? 12 : hour % 12;

              String time =
                  '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

              final String orderNumber =
                  dateTime.millisecondsSinceEpoch.toString();

              return OrderCard(
                date: date,
                deliveryDate: deliveryDate,
                order: order,
                orderNumber: orderNumber,
                time: time,
              );
            },
            itemCount: value.orders.length,
          );
        },
      ),
    );
  }
}
