import 'package:flutter/material.dart';
import 'package:freshkart/view/screens/cart/add_address_page.dart';

class AddAddressContainer extends StatelessWidget {
  const AddAddressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(179, 36, 27, 87)),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Padding(
              padding: EdgeInsets.all(9),
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text(
                    'Add address',
                    style: TextStyle(color: Color.fromARGB(179, 36, 27, 87)),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => const AddAddressPage()),
            );
          },
        ),
      ],
    );
  }
}
