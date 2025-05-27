import 'package:flutter/material.dart';
import 'package:freshkart/core/utils/colors.dart';

class DynamicQuantityInput extends StatefulWidget {
  const DynamicQuantityInput({super.key});

  @override
  State<DynamicQuantityInput> createState() => _DynamicQuantityInputState();
}

class _DynamicQuantityInputState extends State<DynamicQuantityInput> {
  // final String _selectedUnit = 'kg';
  int quantity = 1;
  int unit = 0;
  String get grtQuantity => (quantity + unit).toStringAsFixed(3);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          spacing: 15,
          children: [
            InkWell(onTap: () async {}, child: const Icon(Icons.remove)),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 204, 201, 201),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                quantity.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () async {},
              child: Icon(Icons.add, color: AppColors.greenColor),
            ),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
