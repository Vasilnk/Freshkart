import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/address_provider.dart';
import 'package:freshkart/core/utils/styles.dart';
import 'package:freshkart/view/widgets/cards/address_card.dart';
import 'package:provider/provider.dart';

class Addresses extends StatefulWidget {
  const Addresses({super.key});

  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  int? selectedAddressIndex;

  @override
  Widget build(BuildContext context) {
    if (selectedAddressIndex == null) {
      context.read<AddressProvider>().selectAddress = null;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Shipping Addresses', style: AppStyles.mediumTextStyle),
        ),
        Consumer<AddressProvider>(
          builder: (context, provider, child) {
            return provider.addresses.isEmpty
                ? const SizedBox.shrink()
                : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(provider.addresses.length, (index) {
                      final address = provider.addresses[index];
                      return AddressCard(
                        index: index,
                        address: address,
                        isSelected: selectedAddressIndex == index,
                        onSelect: (value) {
                          setState(() => selectedAddressIndex = value);
                        },
                      );
                    }),
                  ),
                );
          },
        ),
      ],
    );
  }
}
