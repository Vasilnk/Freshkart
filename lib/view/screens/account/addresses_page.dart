import 'package:flutter/material.dart';
import 'package:freshkart/view_model/providers/address_provider.dart';
import 'package:freshkart/view/screens/cart/add_address_page.dart';
import 'package:freshkart/view/widgets/cards/address_card.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';
import 'package:provider/provider.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({super.key});

  @override
  _AddressesPageState createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  int? selectedAddressIndex;
  @override
  void initState() {
    context.read<AddressProvider>().getAllAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Saved Addresses'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<AddressProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.addresses.length,
                      itemBuilder: (context, index) {
                        final address = provider.addresses[index];

                        return AddressCard(
                          index: index,
                          address: address,
                          isSelected: selectedAddressIndex == index,
                          onSelect: (value) {
                            setState(() => selectedAddressIndex = value);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const AddAddressPage()),
          );
        },
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Add'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
