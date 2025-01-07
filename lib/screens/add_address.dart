// ignore_for_file: unnecessary_import, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:second_project/bloc/address_bloc.dart';
import 'package:second_project/models/address_model.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final pincodeController = TextEditingController();
    final stateController = TextEditingController();
    final cityController = TextEditingController();
    final buildingController = TextEditingController();
    final roadNameController = TextEditingController();
    final locationController = TextEditingController();
    // final userid = FirebaseAuth.instance.currentUser?.uid ?? ''; 


    final _formKey = GlobalKey<FormState>();

    InputDecoration professionalInputDecoration(String label, String hint) {
      return InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Address',
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
                    'Address saved successfully',
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
                  TextFormField(
                    controller: nameController,
                    decoration: professionalInputDecoration(
                        'Full Name', 'Enter your full name'),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Location can only contain letters and spaces';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: phoneController,
                    decoration: professionalInputDecoration(
                        'Phone Number', 'Enter your phone number'),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }

                      if (int.tryParse(value) == null) {
                        return 'Phone number must contain only digits';
                      }

                      if (value.length != 10) {
                        return 'Phone number must be 10 digits';
                      }
                      if (!RegExp(r'^[789]\d{9}$').hasMatch(value)) {
                        return 'Phone number must start with 7, 8, or 9';
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
                      TextFormField(
                        controller: pincodeController,
                        decoration: professionalInputDecoration(
                            'Pincode', 'Enter your pincode'),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your pincode';
                          } else if (value.length != 6 ||
                              int.tryParse(value) == null) {
                            return 'Pincode must be 6 digits';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: locationController,
                        decoration: professionalInputDecoration(
                            'Your Location', 'Enter your location'),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your location';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'Location can only contain letters and spaces';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: stateController,
                        decoration: professionalInputDecoration(
                            'State', 'Enter your state'),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your state';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'Location can only contain letters and spaces';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: cityController,
                        decoration: professionalInputDecoration(
                            'City', 'Enter your city'),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'Location can only contain letters and spaces';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: buildingController,
                    decoration: professionalInputDecoration(
                        'Building Name', 'Enter your building name'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your building name';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Location can only contain letters and spaces';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: roadNameController,
                    decoration: professionalInputDecoration(
                        'Road Name', 'Enter your road name'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your road name';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Location can only contain letters and spaces';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final address = AddressModel(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              name: nameController.text,
                              phone: int.parse(phoneController.text),
                              pincode: int.parse(pincodeController.text),
                              state: stateController.text,
                              city: cityController.text,
                              buildingName: buildingController.text,
                              roadName: roadNameController.text,
                              location: locationController.text,
                              userReference: ''
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
                              .add(AddAddressEvent(address));

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Address saved successfully')),
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
                        'Save Address',
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
