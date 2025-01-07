// ignore_for_file: unrelated_type_equality_checks

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second_project/Firebase/address_repo.dart';
import 'package:second_project/screens/add_address.dart';
import 'package:second_project/models/address_model.dart';
import 'package:second_project/screens/edit_address.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  // final ValueNotifier<Set<String>> _selectedAddresses = ValueNotifier({});
  final ValueNotifier<String?> _currentlySelectedAddress = ValueNotifier(null);
       final userid = FirebaseAuth.instance.currentUser?.uid ?? ''; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Address',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 4.0,
        // actions: [
        //   ValueListenableBuilder<Set<String>>(
        //     valueListenable: _selectedAddresses,
        //     builder: (context, selectedAddresses, _) {
        //       if (selectedAddresses.isNotEmpty) {
        //         return IconButton(
        //             icon: const Icon(Icons.delete), onPressed: () {});
        //       }
        //       return const SizedBox();
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddAddress()),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.blue,
                  ),
                  label: const Text(
                    'Add new address',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<AddressModel>>(
                stream: AddressRepository().fetchAddresses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No addresses found.'));
                  }

                  final addresses = snapshot.data!;
                  return ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      final isSelected =
                          _currentlySelectedAddress == address.id;

                      return GestureDetector(
                        onTap: () {
                          _currentlySelectedAddress.value =
                              isSelected ? null : address.id;
                        },
                        child: ValueListenableBuilder<String?>(
                          valueListenable: _currentlySelectedAddress,
                          builder: (context, selectedId, _) {
                            final isSelected = selectedId == address.id;
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: isSelected
                                  ? Colors.teal.shade100
                                  : Colors.white,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                                title: Text(
                                  address.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  '${address.city}, ${address.state} - ${address.pincode}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.blue),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditAddress(
                                              address: address,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () async {
                                        await _deleteAddress(address.id);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ValueListenableBuilder(
                valueListenable: _currentlySelectedAddress,
                builder: (context, _currentlySelectedAddress, _) {
                  if (_currentlySelectedAddress != null) {
                    return Column(
                      children: [
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                _onChoosePressed();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 20.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text('Choose',style: TextStyle(color: Colors.white),)),
                        )
                      ],
                    );
                  }
                  return SizedBox();
                })
          ],
        ),
      ),
    );
  }

  void _onChoosePressed() {
    // Handle the "Choose" action (e.g., pass the selected address to another screen or save it)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text('Address Choose sucessfully!'),
      ),
    );
  }

  Future<void> _deleteAddress(String addressId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Address'),
          content: const Text('Are you sure you want to delete this address?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      try {
        await AddressRepository().deleteAddress(addressId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Address deleted successfully.'),
            backgroundColor: Colors.red,
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete address: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // void _deleteSelectedAddresses() async {
  //   for (final id in _selectedAddresses.value) {
  //     await AddressRepository().deleteAddress(id);
  //   }

  //   // setState(() {
  //   //   _selectedAddresses.clear();
  //   // });

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('Selected addresses deleted successfully.'),
  //       backgroundColor: Colors.red,
  //     ),
  //   );
  // }
}
