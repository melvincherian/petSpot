// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/address_bloc.dart';
import 'package:second_project/models/address_model.dart';
import 'package:second_project/widgets/edit_address_textfield.dart';

class EditAddress extends StatelessWidget {
  final AddressModel address;
  const EditAddress({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: address.name);
    final phoneController =
        TextEditingController(text: address.phone.toString());
    final pincodeController =
        TextEditingController(text: address.pincode.toString());
    final stateController = TextEditingController(text: address.state);
    final cityController = TextEditingController(text: address.city);
    final buildingController =
        TextEditingController(text: address.buildingName);
    final roadNameController = TextEditingController(text: address.roadName);
    final locationController = TextEditingController(text: address.location);

 final userid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Address',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: BlocListener<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressLoading) {
            showDialog(
                context: context,
                builder: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ));
          } else if (state is AddressError) {
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is AddressSuccess) {
            Navigator.pop(context); // Close the loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    'Address updated successfully',
                  )),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomadrressTextFormField(
                    controller: nameController,
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Name can only contain letters and spaces';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomadrressTextFormField(
                    controller: phoneController,
                    label: 'Phone Number',
                    hint: 'Enter your phone number',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (!RegExp(r'^[789]\d{9}$').hasMatch(value)) {
                        return 'Phone number must start with 7, 8, or 9 and be 10 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Address Details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3,
                    ),
                    children: [
                      CustomadrressTextFormField(
                        controller: pincodeController,
                        label: 'Pincode',
                        hint: 'Enter your pincode',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length != 6) {
                            return 'Pincode must be 6 digits';
                          }
                          return null;
                        },
                      ),
                      CustomadrressTextFormField(
                        controller: locationController,
                        label: 'Location',
                        hint: 'Enter your location',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      CustomadrressTextFormField(
                        controller: stateController,
                        label: 'State',
                        hint: 'Enter your state',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      CustomadrressTextFormField(
                        controller: cityController,
                        label: 'City',
                        hint: 'Enter your city',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomadrressTextFormField(
                    controller: buildingController,
                    label: 'Building Name',
                    hint: 'Enter your building name',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 15),
                  CustomadrressTextFormField(
                    controller: roadNameController,
                    label: 'Road Name',
                    hint: 'Enter your road name',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updateaddress = AddressModel(
                              id: address.id,
                              name: nameController.text.trim(),
                              phone: int.parse(phoneController.text),
                              pincode: int.parse(pincodeController.text),
                              state: stateController.text,
                              city: cityController.text,
                              buildingName: buildingController.text,
                              roadName: roadNameController.text,
                              location: locationController.text,
                              userReference: userid
                              );
                          nameController.clear();
                          phoneController.clear();
                          pincodeController.clear();
                          locationController.clear();
                          stateController.clear();
                          cityController.clear();
                          buildingController.clear();
                          roadNameController.clear();
                          context
                              .read<AddressBloc>()
                              .add(UpdateAddressEvent(updateaddress));

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Address updated successfully')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Update Address',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
