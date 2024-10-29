import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 70),
            const Text(
              'My Account',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                SizedBox(width: 162),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Melvin Cherian',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const Text(
              'melvincherian0190@gmail.com',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: () {},
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 40),
                const Icon(Icons.settings),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Settings',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ))
              ],
            ),
            const SizedBox(height: 8),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 40),
                const Icon(Icons.note),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Terms and Conditions',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ))
              ],
            ),
            Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 40),
                const Icon(Icons.edit),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Edit Address',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ))
              ],
            ),
             Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 40),
                const Icon(Icons.sort),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'My Orders',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ))
              ],
            ),
             Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 40),
                const Icon(Icons.location_on),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Edit Address',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400]),
                    onPressed: () {},
                    child: const Text(
                      'LogOut',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
