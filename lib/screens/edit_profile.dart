import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/imagepicker_bloc.dart';
import 'package:second_project/services/shared_pref.dart';
import 'package:second_project/widgets/profile_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  // Load the current profile information from SharedPreferences
  Future<void> _loadUserInfo() async {
    final prefHelper = SharedPrefHelper();
    String? username = await prefHelper.getUserName();
    String? phone = await prefHelper.getUsernumber();  // Assuming phone is stored as email, you can adjust this.
    nameController.text = username ?? '';
    phoneController.text = phone ?? '';
  }

  // Update user profile in SharedPreferences
  Future<void> _updateUserProfile() async {
    final prefHelper = SharedPrefHelper();
    String username = nameController.text;
    String phone = phoneController.text;

    // Save the updated username and phone to SharedPreferences
    await prefHelper.saveUserName(username);
    await prefHelper.saveUserphone(phone); // If storing phone as email
    // Optionally save the new profile image here if needed

    // After updating, navigate back to the profile screen or show success
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () =>
                    context.read<ImagepickerBloc>().add(PickImageEvent()),
                child: BlocBuilder<ImagepickerBloc, ImagepickerState>(
                    builder: (context, state) {
                  if (state is ImagePickerSuccess) {
                    return Image.file(
                      state.imageFile,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    );
                  } else {
                    return const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg',
                        ));
                  }
                }),
              ),
              const SizedBox(height: 30),
              EditTextfield(
                labelText: 'Username',
                hintText: 'Enter your username',
                prefixIcon: const Icon(Icons.person),
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              EditTextfield(
                labelText: 'Phone',
                hintText: 'Enter your phone number',
                prefixIcon: const Icon(Icons.phone),
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateUserProfile(); // Update the profile data
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
