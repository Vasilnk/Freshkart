import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/address_provider.dart';
import 'package:freshkart/view/screens/cart/edit_address.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  final int index;
  final Map<String, dynamic> address;
  final bool isSelected;
  final ValueChanged<int?> onSelect;

  const AddressCard({
    super.key,
    required this.index,
    required this.address,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: const Color.fromARGB(255, 65, 64, 119),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
            child: Row(
              spacing: 10,
              children: [
                Radio<int>(
                  value: index,
                  activeColor: Colors.white,

                  groupValue: isSelected ? index : null,
                  onChanged: (va) {
                    onSelect(va);
                    context.read<AddressProvider>().selectAddress = address;
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address['locality'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address['phone'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (c) => EditAddressPage(
                                name: address['name'],
                                phoneNumber: address['phone'],
                                pincode: address['pincode'],
                                houseName: address['houseName'],
                                locality: address['locality'],
                                city: address['city'],
                                state: address['state'],
                                docId: address['docId'],
                              ),
                        ),
                      ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              context.read<AddressProvider>().deleteAddress(address['docId']);
            },
            icon: const Icon(
              Icons.close,
              size: 15,
              color: Color.fromARGB(255, 204, 64, 54),
            ),
          ),
        ),
      ],
    );
  }
}
