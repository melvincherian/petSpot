// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/bloc/authentication_bloc.dart';
import 'package:second_project/bloc/imagepicker_bloc.dart';
import 'package:second_project/screens/edit_profile.dart';
import 'package:second_project/screens/terms_service.dart';
import 'package:second_project/screens/user%20side/user%20authentication/user_login.dart';
import 'package:second_project/services/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String _email = '';
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  // Load user information from SharedPreferences
  // Future<void> _loadUserInfo() async {
  //   final prefHelper = SharedPrefHelper();
  //   _username = await prefHelper.getUserName() ?? 'No username set';
  //   _email = await prefHelper.getUserEmail() ?? 'No email set';
  //   _imageUrl = await prefHelper.getUserImage() ?? '';
  //    // Empty if no image is saved
  //   // setState(() {
      
  //   // });
  // }
     Future<void> _loadUserInfo() async {
  final prefHelper = SharedPrefHelper();
  final username = await prefHelper.getUserName() ?? 'No username set';
  final email = await prefHelper.getUserEmail() ?? 'No email set';
  final imageUrl = await prefHelper.getUserImage() ?? ''; // Empty if no image is saved

  setState(() {
    _username = username;
    _email = email;
    _imageUrl = imageUrl;
  });
}


  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: const Text('Logout',
              style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await logout(context);
                context.read<AuthenticationBloc>().add(LogoutRequested());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar( 
        title: const Text("MY PROFILE",
        style: TextStyle(fontSize: 28,color:Colors.white,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoggedOut) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ScreenLogin()),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(context),
              const SizedBox(height: 10),
              _buildOptionsList(context),
              const SizedBox(height: 20),
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => context.read<ImagepickerBloc>().add(PickImageEvent()),
            child: BlocBuilder<ImagepickerBloc, ImagepickerState>(
              builder: (context, state) {
                if (state is ImagePickerSuccess && state.imageFile != null) {
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(state.imageFile),
                  );
                } else if (_imageUrl.isNotEmpty) {
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_imageUrl),
                  );
                } else {
                  return const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg',
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _username,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _email,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsList(BuildContext context) {
    return Column(
      children: [
        _buildOptionItem(
          context,
          icon: Icons.edit,
          title: "Edit Profile",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfile()),
            
          ).then((_){
                  _loadUserInfo();
          })
        ),
        _buildOptionItem(
          context,
          icon: Icons.settings,
          title: "Settings",
          onTap: () {},
        ),
        _buildOptionItem(
          context,
          icon: Icons.note_add_outlined,
          title: "Terms and Conditions",
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScreenTermsAndConditions()),
          ),
        ),
        _buildOptionItem(
          context,
          icon: Icons.location_on,
          title: "Edit Address",
          onTap: () {},
        ),
        _buildOptionItem(
          context,
          icon: Icons.sort,
          title: "My Orders",
          onTap: () {},
        ),
        _buildOptionItem(
          context,
          icon: Icons.wallet,
          title: "My Wallet",
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildOptionItem(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.teal),
          title: Text(title, style: const TextStyle(fontSize: 16)),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => _showLogoutDialog(context),
        child: const Text(
          "Logout",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLogged', false); // Set login state to false
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ScreenLogin()),
      (route) => false,
    );
  }
}
