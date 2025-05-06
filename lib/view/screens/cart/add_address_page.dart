import 'package:flutter/material.dart';
import 'package:freshkart/models/address_model.dart';
import 'package:freshkart/view_model/providers/address_provider.dart';
import 'package:freshkart/core/utils/styles.dart';
import 'package:freshkart/view/widgets/appbar/appbar.dart';
import 'package:freshkart/view/widgets/text_field/outlined_text_formfield.dart';
import 'package:provider/provider.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController localityController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController houseController = TextEditingController();
TextEditingController pincodeController = TextEditingController();
String? selectedState;
final formKey = GlobalKey<FormState>();

class _AddAddressPageState extends State<AddAddressPage> {
  final List<String> states = ['Kerala', 'Tamil Nadu', 'Karnataka'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Add Address'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 15,
              children: [
                const SizedBox(height: 30),
                OutlinedTextFormfield(
                  controller: nameController,
                  label: 'Name',
                ),
                OutlinedTextFormfield(
                  controller: phoneController,
                  label: 'Phone',
                  isNumberKeybord: true,
                ),
                OutlinedTextFormfield(
                  controller: pincodeController,
                  label: 'Pincode',
                  isNumberKeybord: true,
                ),
                OutlinedTextFormfield(
                  controller: houseController,
                  label: 'House Name',
                ),
                OutlinedTextFormfield(
                  controller: localityController,
                  label: 'Locality',
                ),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedTextFormfield(
                        controller: cityController,
                        label: 'City',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        value: selectedState,
                        decoration: InputDecoration(
                          labelText: 'State',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        items:
                            states.map((state) {
                              return DropdownMenuItem<String>(
                                value: state,
                                child: Text(state),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedState = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AddressModel address = AddressModel(
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        locality: localityController.text.trim(),
                        city: cityController.text.trim(),
                        state: selectedState ?? 'Unknown',
                        pincode: pincodeController.text.trim(),
                        houseName: houseController.text.trim(),
                      );
                      context.read<AddressProvider>().addNewAddress(address);
                      Navigator.pop(context);
                    }
                  },
                  style: AppStyles.bigButton,
                  child: Text('Add', style: AppStyles.bigButtonTextStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
