import 'package:flutter/material.dart';
import 'package:freshkart/core/routes.dart';

class Constants {
  static Map<String, Map<String, dynamic>> profileItems = {
    'My Details': {
      'icon': const Icon(Icons.account_box, color: Colors.white),
      'screen': Routes.myDetails,
    },
    'Orders': {
      'icon': const Icon(Icons.storage, color: Colors.white),
      'screen': Routes.orders,
    },
    'Delivery Address': {
      'icon': const Icon(Icons.location_on, color: Colors.white),
      'screen': Routes.deliveryAddress,
    },
    'Wishlist': {
      'icon': const Icon(Icons.favorite_rounded, color: Colors.white),
      'screen': Routes.wishlist,
    },
    'Help': {
      'icon': const Icon(Icons.help_outline_sharp, color: Colors.white),
      'screen': Routes.help,
    },
    'About': {
      'icon': const Icon(Icons.info_outline, color: Colors.white),
      'screen': Routes.about,
    },
  };

  static List<PopupMenuItem<String>> popupMenus = [
    const PopupMenuItem<String>(value: 'all', child: Text("All")),
    const PopupMenuItem<String>(value: 'discount', child: Text("Discount")),
    const PopupMenuItem<String>(
      value: 'lowToHigh',
      child: Text("Price - low to high"),
    ),
    const PopupMenuItem<String>(
      value: 'highToLow',
      child: Text("Price - high to low"),
    ),
  ];
}
