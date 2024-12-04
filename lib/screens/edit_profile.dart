// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/imagepicker_bloc.dart';
import 'package:second_project/screens/edit_phonenumber.dart';
import 'package:second_project/services/shared_pref.dart';
import 'package:second_project/widgets/profile_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefHelper = SharedPrefHelper();
    String? username = await prefHelper.getUserName();
    String? dob = await prefHelper.getUserDob();
    String? email = await prefHelper.getUserEmail();

    nameController.text = username ?? '';
    dobController.text = dob ?? '';
    emailController.text = email ?? '';
  }

  Future<void> _updateUserProfile() async {
    final prefHelper = SharedPrefHelper();
    String username = nameController.text;
    String dobc = dobController.text;
    String email = emailController.text;
    
    await prefHelper.saveUserName(username);
    await prefHelper.saveUserdob(dobc);
    await prefHelper.saveUserEmail(email);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Profile updated successfully!'),
        duration: Duration(seconds: 2),
      ),
    );

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
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Profile Picture Section
                GestureDetector(
                  onTap: () =>
                      context.read<ImagepickerBloc>().add(PickImageEvent()),
                  child: BlocBuilder<ImagepickerBloc, ImagepickerState>(
                    builder: (context, state) {
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: state is ImagePickerSuccess
                                ? FileImage(state.imageFile)
                                : const NetworkImage(
                                    'https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg',
                                  ) as ImageProvider,
                          ),
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                // Name Field
                EditTextfield(
                  labelText: 'Username',
                  hintText: 'Enter your Username',
                  prefixIcon: const Icon(Icons.person),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Email Field
                EditTextfield(
                  labelText: 'Email',
                  hintText: 'Enter your Email',
                  prefixIcon: const Icon(Icons.email),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Date of Birth Picker
                TextFormField(
                  controller: dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    hintText: 'Select your date of birth',
                    prefixIcon: const Icon(Icons.date_range),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onTap: () async {
                    
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      
                      dobController.text =
                          "${selectedDate.toLocal()}".split(' ')[0];
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your Date of Birth';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Phone Number
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Phone Number',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPhonenumber(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Update Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateUserProfile();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 50.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'UPDATE ACCOUNT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
