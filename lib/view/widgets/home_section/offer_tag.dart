import 'package:flutter/material.dart';

class OfferTag extends StatefulWidget {
  final String price;
  final String offerPrice;
  const OfferTag({super.key, required this.price, required this.offerPrice});
  @override
  _OfferTagState createState() => _OfferTagState();
}

class _OfferTagState extends State<OfferTag>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int? percentage;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    int price = int.parse(widget.price);
    int offerPrice = int.parse(widget.offerPrice);
    percentage = ((price - offerPrice) / price * 100).round();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "$percentage% Offer",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
